module ImagesHelper
  def find_img_food id
    @images = Image.find_image_food id
  end
end
