class BrandsController < ApplicationController
before_filter :current_user
before_action :set_brand, only: [:edit, :update, :destroy]
	def index
		    @brands = Brand.all
        @brands = @brands.like(params[:filter]) if params[:filter]
        @brands = @brands.order(updated_at: :desc) if params[:recent]
        @brands_size = @brands.size
        @brands = @brands.page(params[:page]).per(15)
	end


def new
    @brand = Brand.new
    render :layout => false
  end

  def create
    @brand = Brand.new(brand_params)
    
    if @brand.save
    @photo = Brandimage.new(:upload => params[:brand][:file])
    @photo.brand_id = @brand.id
    @photo.save
    @photo.update(:phourl => "brands/uploads/"+@photo.id.to_s+"/"+@photo.upload_file_name.to_s )

      render :text => "success"
    else
      render :text => "error"
    end
  end

  def edit
  @brand = Brand.find(params[:id])
  render :layout => false
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      if params[:brand][:file]
      @brand.brandimage.destroy
      @photo = Brandimage.new(:upload => params[:brand][:file])
      @photo.brand_id = @brand.id
      @photo.save
      @photo.update(:phourl => "brands/uploads/"+@photo.id.to_s+"/"+@photo.upload_file_name.to_s )

      end
      render :text => "success"
    else
      render :text => "error"
    end
  end

def destroy
    @brand.destroy

    redirect_to brands_path
  end


    def brand_params
    params.require(:brand).permit(:name,:briefdescription,:detaildescription)
  end

    def set_brand
    @brand = Brand.find(params[:id])
  end
end
