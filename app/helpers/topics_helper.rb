module TopicsHelper
  def intfy_pararams_page!
    params[:page] = params[:page].try(:to_i) || 1
    params[:page] = 1 if params[:page] <= 0
    params[:page]
  end
end
