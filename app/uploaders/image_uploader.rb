class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # 画像加工機能(MiniMagick)の使用
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # ファイルがアップロードされていない時はデフォルトのファイルを使用
  def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # サムネイル画像を作成
  version :thumb do
    process resize_to_fit: [100, 100]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # 投稿可能なファイル形式を制限
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  # 投稿可能なファイルサイズの上限を5MBに制限
  def size_range
    0..5.megabytes
  end

  # ファイルの形式を jpg 変換
  process convert: "jpg"

  # 画像サイズを変更 (縦幅:200px, 横幅:300px)
  process resize_to_limit: [200, 300]

  # 投稿した画像のファイル名をランダムに変更し保存
  # def filename
  #   "#{secure_token}.#{file.extension}" if original_filename.present?
  # end

  # ファイル名の拡張子を jpg に変更
  def filename
    super.chomp(File.extname(super)) + ".jpg" if original_filename.present?
  end

  # protected

  # def secure_token
  #   var = :"@#{mounted_as}_secure_token"
  #   model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  # end
end
