def template from, to, as_root = false
  template_path = File.expand_path("../../templates/#{from}", __FILE__)
  template = ERB.new(File.new(template_path).read).result(binding)
  upload! StringIO.new(template), to

  execute :sudo, :chmod, "644 #{to}"
  execute :sudo, :chown, "root:root #{to}" if as_root
end
