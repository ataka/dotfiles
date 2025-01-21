#!/usr/bin/env ruby

config_dir = ARGV[0]
workspace_id = ARGV[1]
apps = `aerospace list-windows --workspace #{workspace_id} --format '%{app-name}'`
icon_map = "#{config_dir}/plugins/icon_map.sh"

icons = apps.each_line
          .uniq
          .map { |app| `#{icon_map} #{app}` }
          .map { |line| line.chomp }

if icons.empty? then
  puts "--"
else
  puts icons.join()
end
