# Based on https://gist.github.com/yannis/7806288
require "yaml"

ROOT_PATH = File.expand_path("~/Desktop/ember_docs_offline/") + '/'
TABLE_OF_CONTENT_PATH = ROOT_PATH+"website/data/guides.yml"
GUIDE_FILES_PATH = ROOT_PATH+"website/source/guides/"

def concatenated_paths
  yaml_table_of_content = YAML.load_file TABLE_OF_CONTENT_PATH
  concatenated_paths = []
  yaml_table_of_content.each do |k,v|
    v.each do |hash|
      title = hash["title"]
      title = "#{k} - #{title}"
      path = hash["url"]
      unless path.match /.html/
        pathsplit = path.split "/"
        path += "/index" if pathsplit.size == 1
        path = GUIDE_FILES_PATH+path
        unless File.exist? path+".md"
          path = path+"/index"
          p "file #{path} does not exist" unless File.exist? path+".md"
        end
        concatenated_paths << [title, path+".md"]
      end
    end
  end
  return concatenated_paths
end

def remove_js_bin
  file_name = "#{ROOT_PATH}ember_guides_combined.md"

  text = File.read(file_name)
  text.gsub! /### Live Preview/, ""
  text.gsub! /<a class="jsbin-embed".+/, ""

  File.open(file_name, "w") do |file|
    file.puts text
  end
end

def concatenate_files
  strings = []
  concatenated_paths.each do |title, path|
    header_underline = "=" * title.length
    strings << "#{title}\n#{header_underline}"
    File.open(path, "r") do |f|
      strings << f.read
    end
  end
  return strings.join("\n")
end

# system "mkdir #{ROOT_PATH}"
system "cd #{ROOT_PATH}"
# system "git clone https://github.com/emberjs/website.git #{ROOT_PATH}website"
File.write "#{ROOT_PATH}ember_guides_combined.md", concatenate_files
remove_js_bin
# system "gimli -file #{ROOT_PATH}ember_guides_combined.md > #{ROOT_PATH}ember_guides_combined.pdf"
p "done"