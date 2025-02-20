namespace :dev do
  desc "Collect TODO/FIXME/FIXIT comments from the codebase and save to docs/TODO.md"
  task :todo do
    todo_list = []

    Dir.glob("**/*", File::FNM_DOTMATCH).each do |file|
      next if File.directory?(file) || file.match?(
        %r{(node_modules|\.git|\.lock$|log/|tmp/|public/|vendor/|storage/|coverage/|db/schema.rb|TODO.md|lib/tasks/dev.rake|\.DS_Store|app/assets/)}
      )

      # Uncomment this to debug output
      # puts "Checking file: #{file}"

      File.readlines(file, encoding: "UTF-8", invalid: :replace, undef: :replace, replace: "?").each_with_index do |line, index|
        if line.match?(/TODO|FIXIT|FIXME/i)
          todo_list << "#{file}:#{index + 1}: #{line.strip}"
        end
      end
    end

    content = todo_list.empty? ? "# TODOs\n\nNo TODOs found." : "# TODOs\n\n" + todo_list.join("\n")
    File.open("TODO.md", "w") { |f| f.write(content) }

    puts "✅ TODO.md updated!"
  end
end
