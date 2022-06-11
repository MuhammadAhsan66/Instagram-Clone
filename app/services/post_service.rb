class PostService
  def initialize(params, post)
    @params = params
    @post = post
  end

  def save_photo
    @params[:photos_list].each do |img|
      @post.photos.create!(image: img)
    end
  end
end
