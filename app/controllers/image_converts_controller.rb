class ImageConvertsController < ApplicationController
  def create
    converter = MagickConverter.new(params[:file])

    if image = converter.call(option_params)
      send_file image.path, type: image.mime_type, disposition: 'inline'
    else
      render json: { message: 'File not found'}, status: :unprocessable_entity
    end
  end

  private

  def option_params
    params.permit(:resize, :rotate, :crop, :format)
  end
end
