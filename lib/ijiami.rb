# -*- coding: utf-8 -*-
require "ijiami/version"
require 'ijiami/api'
require 'thor'
require 'pathname'

module Ijiami
  class CLI < Thor
    desc 'assemble USERNAME APK_PATH', '上传－加密－下载'
    def assemble(username, apk_path)
      result = upload(username, apk_path)
      unless result["code"] == 1100
        return
      end

      result = encrypt(username, result["body"]["appId"])
      unless result["code"] == 1100
        return
      end

      result = check(username, result["body"]["appId"])
      unless result["code"] == 1100
        return
      end

      puts result["downUrl"]
    end

    desc 'verify USERNAME', '获取用户信息'
    def verify(username)
      result = Ijiami::Api.new(username).verify
      $stdout.puts result
      result
    end

    desc 'upload USERNAME FILE_PATH', '上传 APK'
    def upload(username, file_path)
      full_path = File.expand_path(file_path)
      $stdout.puts "Uploading apk #{full_path}"
      result = Ijiami::Api.new(username).upload_local(File.expand_path(full_path))
      $stdout.puts result
      result
    end

    desc 'encrypt USERNAME APP_ID', '加密'
    def encrypt(username, app_id)
      result = Ijiami::Api.new(username).encrypt(app_id)
      $stdout.puts result
      result
    end

    desc 'check USERNAME APP_ID', '查看加密结果'
    def check(username, app_id)
      result = Ijiami::Api.new(username).encrypt_result(app_id)
      $stdout.puts result
      while result["code"] != 1100
        sleep 5
        result = Ijiami::Api.new(username).encrypt_result(app_id)
        $stdout.puts result
      end

      result
    end

    desc 'download URL', '下载 apk'
    def download(url, local_path = nil)
      if local_path
        `wget #{url}`
      end
    end

  end
end
