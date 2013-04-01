class ImagesController < ApplicationController

def destroy
  @image = Image.find(params[:id])

  @project = Project.find(@image.project_id)

  screenshot_count = @project.images.where(:image_type => "screenshot").length

  if screenshot_count == 1
    flash[:notice] = "You must include at least one screenshot for this project"
    redirect_to edit_project_path(@project)
    else
    @image.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end

end
