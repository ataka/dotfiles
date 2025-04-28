#!/usr/bin/env ruby
# frozen_string_literal: true

config_dir = ARGV[0]
workspace_id = ARGV[1]
apps = `aerospace list-windows --workspace #{workspace_id} --format '%{app-name}'`
icon_map = "#{config_dir}/plugins/icon_map.sh"

icons = apps.each_line
            .uniq
            .map { |app| `#{icon_map} #{app}` }
            .map(&:chomp)

if icons.empty?
  puts '--'
else
  puts icons.join
end
