require 'open-uri'
ActiveAdmin.register_page "Dashboard" do
  content do
    @images = Image.all
  columns do
    column do
      panel "Recent Category" do
        table_for Category.order("created_at desc").limit(5) do
          column :name
          column :created_at
        end
      end
      panel "Recent Comments" do
        table_for Comment.order("created_at desc").limit(5) do
          column :com_email
          column :body
          column :image
        end
      end
    end
  end
  render partial: 'form'
  end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content

