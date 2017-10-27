namespace :setup do
  desc "TODO"
  task uploadi: :environment do
    name_list = []

    i = 0
    j = 0
    Dir.entries('app/assets/images/Categories').select do |x|
      if "#{x}" == '.' || "#{x}" == '..' || "#{x}" == ''
      else
        i += 1
        ci = Category.create(name: "#{x}")
        Dir.entries('app/assets/images/Categories/'+"#{x}").each do |file|
          if file == '.' || file == '..' || file == ''
          else
            c = 'assets/Categories/'+x+'/'+file
            puts c
            puts ''
            Image.create(path: c, likes: 0, category: ci)
            j +=1
          end

        end
      end
    end

  end

end
