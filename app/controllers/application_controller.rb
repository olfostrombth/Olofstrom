class ApplicationController < ActionController::Base

  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  #Helper method for getting current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :shuffle_hash
  def shuffle_hash
    Hash[self.to_a.sample(self.length)]
  end
  helper_method :shuffle_hash!
  def shuffle_hash!
    self.replace(self.shuffle)
  end

  helper_method :get_activities
  def get_activities
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  helper_method :get_steps_info
  def get_steps_info(catname, stepname, completion, substepcount)
    done = 0
    completion.each do |catkey, catval|
      if catkey == catname
        catval.each do |stepkey, stepval|
          if stepkey == stepname
            stepval.each do |substepkey, substepval|
              if substepval
                done = done+1
              end
            end
          end
        end
      end
    end
    if done == 0
      percent = 0
    else
      donex = done*100
      substepcountx = substepcount*100
      percent = (done.to_f / substepcount)*100
    end
    returna = {}
    returna["percent"] = percent.to_s.split(".")
    returna["done"] = "#{done} / #{substepcount}"
    returna["donea"] = done
    returna["substeps"] = substepcount
    return returna
  end

  helper_method :breadcrumbs
  def breadcrumbs
    modul = params[:category_name] if params[:category_name]
    step = params[:step_name] if params[:step_name]
    home = view_context.link_to "Home", root_path
    if modul
      modulee = view_context.link_to modul, category_path(modul)
      if step
        stepp = view_context.link_to step, step_path(:category_name => modul, :step_name => step)
        return home +" > "+ modulee + " > " + stepp
      end
      return home +" > "+ modulee
    end
    return home
  end

end
