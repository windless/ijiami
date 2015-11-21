require "ijiami/version"
require 'ijiami/api'
require 'thor'
require 'pathname'

module Ijiami
  class CLI < Thor
    desc 'assemble USERNAME', '上传－加密－下载'
    def assemble(username, apk_path)
    end

    desc 'verify USERNAME', '获取用户信息'
    def verify(username)
      $stdout.puts Ijiami::Api.new(username).verify
    end

    desc 'upload USERNAME FILE_PATH', '上传 APK'
    def upload(username, file_path)
      $stdout.puts Ijiami::Api.new(username).upload_local(File.expand_path(file_path))
    end

    desc 'encrypt USERNAME APP_ID', '加密'
    def encrypt(username, app_id)
      $stdout.puts Ijiami::Api.new(username).encrypt(app_id)
    end

    desc 'check USERNAME APP_ID', '查看加密结果'
    def check(username, app_id)
      $stdout.puts Ijiami::Api.new(username).encrypt_result(app_id)
    end

  end
end
