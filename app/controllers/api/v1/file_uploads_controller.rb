module Api
  module V1
    class FileUploadsController < Api::V1::ApiController
      before_action :set_file_upload, only: %i[ show edit update destroy ]

      # GET /file_uploads
      def index
        @file_uploads = FileUpload.all
      end

      # GET /file_uploads/1
      def show
      end

      # GET /file_uploads/new
      def new
        @file_upload = FileUpload.new
      end

      # GET /file_uploads/1/edit
      def edit
      end

      # POST /file_uploads
      def create
        @file_upload = FileUpload.new(file_upload_params)

        if @file_upload.save
          redirect_to @file_upload, notice: "File upload was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /file_uploads/1
      def update
        if @file_upload.update(file_upload_params)
          redirect_to @file_upload, notice: "File upload was successfully updated.", status: :see_other
        else
          render :edit, status: :unprocessable_entity
        end
      end

      # DELETE /file_uploads/1
      def destroy
        @file_upload.destroy!
        redirect_to file_uploads_url, notice: "File upload was successfully destroyed.", status: :see_other
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_file_upload
          @file_upload = FileUpload.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def file_upload_params
          params.require(:file_upload).permit(:name, :size, :url, :folder_id, :deleted_at)
        end
    end
  end
end
