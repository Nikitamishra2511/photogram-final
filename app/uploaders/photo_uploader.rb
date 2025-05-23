class PhotoUploader < CarrierWave::Uploader::Base
  # Store uploaded files locally (under public/)
  storage :file

  # Store under: public/uploads/photo/image/[:id]
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end

