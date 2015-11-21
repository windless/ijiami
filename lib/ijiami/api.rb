require 'net/http'
require 'json'
require 'rest-client'

module Ijiami
  class Api
    HOST = "http://116.255.254.146"
    def initialize(username)
      @username = username
    end

    def verify
      res = RestClient.get HOST + '/userVerify', { params: { userName: @username } }
      JSON.parse(res)
    end

    def upload_local(file_path)
      response = RestClient.post HOST + '/operate/uploadByLocal', { userName: @username, File: File.new(file_path) }
      JSON.parse(response.body)
    end

    def upload_path(url_path)
    end

    def encrypt(app_id)
      response = RestClient.get HOST + '/operate/autoEncrypt', { params: { appId: app_id, userName: @username } }
      JSON.parse(response.body)
    end

    def encrypt_result(app_id)
      response = RestClient.get HOST + '/operate/backResult', { params: { appId: app_id, userName: @username } }
      JSON.parse(response.body)
    end

  end
end
