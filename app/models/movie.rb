# frozen_string_literal: true

require 'google/cloud/storage'

class Movie < ContentSchema
  self.table_name = 'TMovie'

  def favorite
    pref = UserPreference.first
    return true if pref.favourites.include? self.TMovie_id
    false
  end

  def image
    img = MovieCover.where(movie_id: self.TMovie_id).first

    if img.nil?
      url = "/assets/img/#{self.TMovie_id}.jpeg"
    else
      url = img.image_url
    end
    url
  end

  def upload_sample_to_gcs(cover_image)
    storage = Google::Cloud::Storage.new(
      credentials: {
        "type": "service_account",
        "project_id": "nordstream",
        "private_key_id": "d914b2e115a94f9424fea12ac02a3686e81f948c",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1RZuXZACgTsrX\nSQ/RgJnVkv/Kjxg9ZJBwpytLPnzws2s+/GiH7+SMJSt7u2QvrG3uC6ucC/+LKbvn\nvP6M8rz653TshV9CEO8PdgcQGS/Q+BL/nabueiBQjyB1EUcXt/FUdsXds9M2lM00\nI2+mwaDko90pnkPBeRkLabITTxBLBI6EY2lnXF5eJhW9EMysfsyVRPREmzD+tIPP\nzGmRjhZQWfezqybVlLQxCg/ddBSip9xTGBcZxFtWL+5TW5GFoZ0dlovFjrmx+fX2\nPG6aTpAvTU+hEyUAJOewevqw9zQUKW1gyxxzWWxooXh8eQz8qYlIsPt8ApxM9TUy\nODZSnEvvAgMBAAECggEAQnGPRICdUiVPaHYZXDt9J7HIHKEyy14PK5u63Mu81CWP\ny/iNADbIWS5Or/3SDT9w0+5nKr2jH4lenOTDkTpwVq98Ri3k6rx2Q/6JPDdfNYOY\nwyUwSP1u1th/lymMG3+K7+DRSiBd7QXB6biLdl5G8Ue3C0g9oa8XpP1LDpTObhBR\nPtCVwB7C9/s23s95/0vmHtUHDWSjoibPBeMYmSieC85V9yNkXve9aahyt6ZUp1LS\n7V3AROm5gwkuRz9UXJajh2C7BVfgjPU0CenxBOQmVwRyiv570gTsiDzFp+sz+0jY\ngHHFbcsujdvLBvYwn6VcfwR7BWAgyn9OATUfY02mwQKBgQDmRbY5BG3KcxSZyM4C\nPYiYXrEVN1BPFyHW7plvt1JWkI+Se2rGeiQ2mthTyC7ieEMiUU6SlqAXuoctfyka\nxzMG9kAfsbGeuy/1udr95c0kCNPFNEZxvkZQ6FCF+9qK4Wx38j7jFWHqokxPVtW7\nNvY8RkhZJJcX+f+/h3r3StAp3wKBgQDJhmDAcFqrdkm+WKqfelgrGrrFLCh+CoBl\nmVPmj47nEZFMVLDgNv3cZZmtlrKjme8iva6v/D8oVu+mdYv28n2s6qeJycnnGUGP\nibUQzjKR0hXGiS27tqlBiSCGWRHgkPUk57wudYMWV5UdLpOof/Y5gNTt25iNGULo\nm1ay/ok/8QKBgBR8AxfTYwjtb9m2WU0tuCcF1W7zursubZ43H4MmpbZ5qav4Oqlp\nWCtbXv8lAba3yBEXdovnxloWB8xuUXPGYK2v3khzgD+Em2GapPaNKNCZ0Gzsl4+q\nw4qTAAbLPse4AfQxopKE5m7+/RbZvK2o2ALIpcr4TFCftraNEM1K5HW1AoGAK2dA\nwVGxhYpVeaSZIv3zrVz1avAGzJawbrFmS5sRuRykgZ8f9TqC1IwhXCy/ztKhmYbm\n78pRQ/vtY5mfipFRlgN4EAog7SAYabTMBZGTfKqVvAvhiLNfotjI44adfhNaaRds\nBUmT8STt3bohXUIqItpngc8w/Pq62WRTePuvTdECgYEAhOnJ4hWchjnY3vzEM6/9\ntmdlZEDVjrFHqEJ0G3PprrtHN0axiDBfUwnYCVUqrWkCiTXol1yHjFQTS4CyESIm\nDLSei5YXosji5xioQ+dZwrbV+uK55nZX8eUPbX34+OrjawIZYIgHk3IVe+81lyBn\nAINrG+QoZPsM361ZJ1MVT/M=\n-----END PRIVATE KEY-----\n",
        "client_email": "nordstream-gcs@nordstream.iam.gserviceaccount.com",
        "client_id": "103830011582867469394",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/nordstream-gcs%40nordstream.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    )
    bucket = storage.bucket('nordstream_movie_covers_bucket')
    image_file = bucket.create_file StringIO.new(cover_image), SecureRandom.uuid

    MovieCover.create(movie_id: self.TMovie_id, image_url: image_file.public_url)
  end
  def upload_to_gcs(cover_image, movie_data)


    storage = Google::Cloud::Storage.new(
      credentials: {
        "type": "service_account",
        "project_id": "nordstream",
        "private_key_id": "d914b2e115a94f9424fea12ac02a3686e81f948c",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1RZuXZACgTsrX\nSQ/RgJnVkv/Kjxg9ZJBwpytLPnzws2s+/GiH7+SMJSt7u2QvrG3uC6ucC/+LKbvn\nvP6M8rz653TshV9CEO8PdgcQGS/Q+BL/nabueiBQjyB1EUcXt/FUdsXds9M2lM00\nI2+mwaDko90pnkPBeRkLabITTxBLBI6EY2lnXF5eJhW9EMysfsyVRPREmzD+tIPP\nzGmRjhZQWfezqybVlLQxCg/ddBSip9xTGBcZxFtWL+5TW5GFoZ0dlovFjrmx+fX2\nPG6aTpAvTU+hEyUAJOewevqw9zQUKW1gyxxzWWxooXh8eQz8qYlIsPt8ApxM9TUy\nODZSnEvvAgMBAAECggEAQnGPRICdUiVPaHYZXDt9J7HIHKEyy14PK5u63Mu81CWP\ny/iNADbIWS5Or/3SDT9w0+5nKr2jH4lenOTDkTpwVq98Ri3k6rx2Q/6JPDdfNYOY\nwyUwSP1u1th/lymMG3+K7+DRSiBd7QXB6biLdl5G8Ue3C0g9oa8XpP1LDpTObhBR\nPtCVwB7C9/s23s95/0vmHtUHDWSjoibPBeMYmSieC85V9yNkXve9aahyt6ZUp1LS\n7V3AROm5gwkuRz9UXJajh2C7BVfgjPU0CenxBOQmVwRyiv570gTsiDzFp+sz+0jY\ngHHFbcsujdvLBvYwn6VcfwR7BWAgyn9OATUfY02mwQKBgQDmRbY5BG3KcxSZyM4C\nPYiYXrEVN1BPFyHW7plvt1JWkI+Se2rGeiQ2mthTyC7ieEMiUU6SlqAXuoctfyka\nxzMG9kAfsbGeuy/1udr95c0kCNPFNEZxvkZQ6FCF+9qK4Wx38j7jFWHqokxPVtW7\nNvY8RkhZJJcX+f+/h3r3StAp3wKBgQDJhmDAcFqrdkm+WKqfelgrGrrFLCh+CoBl\nmVPmj47nEZFMVLDgNv3cZZmtlrKjme8iva6v/D8oVu+mdYv28n2s6qeJycnnGUGP\nibUQzjKR0hXGiS27tqlBiSCGWRHgkPUk57wudYMWV5UdLpOof/Y5gNTt25iNGULo\nm1ay/ok/8QKBgBR8AxfTYwjtb9m2WU0tuCcF1W7zursubZ43H4MmpbZ5qav4Oqlp\nWCtbXv8lAba3yBEXdovnxloWB8xuUXPGYK2v3khzgD+Em2GapPaNKNCZ0Gzsl4+q\nw4qTAAbLPse4AfQxopKE5m7+/RbZvK2o2ALIpcr4TFCftraNEM1K5HW1AoGAK2dA\nwVGxhYpVeaSZIv3zrVz1avAGzJawbrFmS5sRuRykgZ8f9TqC1IwhXCy/ztKhmYbm\n78pRQ/vtY5mfipFRlgN4EAog7SAYabTMBZGTfKqVvAvhiLNfotjI44adfhNaaRds\nBUmT8STt3bohXUIqItpngc8w/Pq62WRTePuvTdECgYEAhOnJ4hWchjnY3vzEM6/9\ntmdlZEDVjrFHqEJ0G3PprrtHN0axiDBfUwnYCVUqrWkCiTXol1yHjFQTS4CyESIm\nDLSei5YXosji5xioQ+dZwrbV+uK55nZX8eUPbX34+OrjawIZYIgHk3IVe+81lyBn\nAINrG+QoZPsM361ZJ1MVT/M=\n-----END PRIVATE KEY-----\n",
        "client_email": "nordstream-gcs@nordstream.iam.gserviceaccount.com",
        "client_id": "103830011582867469394",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/nordstream-gcs%40nordstream.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    )

    bucket = storage.bucket('nordstream_movie_covers_bucket')
    image_file = bucket.create_file(cover_image.tempfile, cover_image.original_filename)
    movie_file = bucket.create_file(movie_data.tempfile, movie_data.original_filename)

    MovieCover.create(movie_id: self.TMovie_id, image_url: image_file.public_url, movie_url: movie_file.public_url)
  end
end
