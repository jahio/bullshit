#!/usr/bin/env ruby
# Usage:
#
# $ ruby rack-server.rb
require 'rack'
require 'json'
require 'securerandom'

class DataStorageServer
  # You may initialize any variables you want to use across requests here
  # NB: Normally I'd prefer to back this with PostgreSQL, or at least Redis or
  # something along those lines, but given the restrictions on this project,
  # this hash will do.
  def initialize
    @storage = {}
  end

  # Download an Object
  #
  # GET /data/{repository}/{objectID}
  # Response
  #
  # Status: 200 OK
  # {object data}
  # Objects that are not on the server will return a 404 Not Found.
  def get(path)
    repository = path.split(/\//)[2]
    objectid = path.split(/\//)[3]
    obj = storage_fetch(repository, objectid)
    if obj
      ['200', {'Content-Type' => 'application/json'},
        [
          obj[objectid][:object_data]
        ]
      ]
    else
      ['404', {}, ["Repository #{repository} or ObjectID #{objectid} not found: #{path}"]]
    end
  end

  #
  # Create an object
  #
  # PUT /data/{repository}
  # curl -i -X PUT http://localhost:8282/foo -d '{"foo":"bar"}'
  # Note: No ObjectID in this request, the server will assign one for you.
  #
  # Response:
  # Status: 201 Created
  # {
  #   "oid": 2845f5a412dbdfacf95193f296dd0f5b2a16920da5a7ffa4c5832f223b03de96,
  #   "object_data":
  #   {
  #     ...
  #   }
  # }
  #
  def put(path, body)
    repository = path.split(/\//)[2]
    object_data = {object_data: body}
    oid = gen_id
    unless @storage[repository]
      @storage[repository] = []
    end
    if !storage_fetch(repository, object_data)
      @storage[repository] << {oid => object_data}
    end
    [201, {'Content-Type' => 'application/json'},
      [
        {
          oid: oid,
          size: object_data[:object_data].length
        }.to_json
      ]
    ]
  end

  #
  # DELETE /repository/UUID
  # curl -i -X DELETE http://localhost:8282/0c5943c1f1824f934f819a6b9aea8f3579ff313c9d006d6a731b43122474a1db
  # Status: 200 OK
  # No Body
  #
  def delete(path)
    repository = path.split(/\//)[2]
    objectid = path.split(/\//)[3]
    if storage_fetch(repository, objectid) && storage_delete(repository, objectid)
      ['200', {}, []]
    else
      ['404', {}, ["Repository #{repository} or ObjectID #{objectid} not found: #{path}"]]
    end
  end


  def call(env)
    path = env['PATH_INFO']
    if env['rack.input']
      body = env['rack.input'].read
    end
    case env['REQUEST_METHOD']
    when 'GET'
      get(path)
    when 'PUT'
      put(path, body)
    when 'DELETE'
      delete(path)
    end
  end

private

  #
  # Private method to generate unique IDs
  #
  def gen_id
    SecureRandom.hex(32)
  end

  #
  # Retrieves the object from the repository specified
  #
  def storage_fetch(repository, oid)
    unless @storage[repository]
      return false
    end
    if @storage[repository]
      obj = @storage[repository].select { |x| x[oid] }
      if obj
        return obj.first
      end
    else
      return false
    end
    return false
  end

  #
  # Deletes the specified storage item
  #
  def storage_delete(repository, oid)
    if !@storage[repository]
      return true
    else
      if !storage_fetch(repository, oid)
        return true
      end
      i = @storage[repository].index { |x| x[oid] }
      @storage[repository].delete_at i
      return true
    end
    return false
  end

end

# This starts the server if the script is invoked from the command line. No
# modifications needed here.
if __FILE__ == $0
  app = Rack::Builder.new do
    use Rack::Reloader
    run DataStorageServer.new
  end.to_app

  Rack::Server.start(app: app, Port: 8282)
end
