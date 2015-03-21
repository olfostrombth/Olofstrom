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

  helper_method :badges
  #Div names for badges
  def badges
    return ["bluebadge", "greenbadge", "orangebadge", "pinkbadge"]
  end

  helper_method :get_completion
  def get_completion(user)
    #Really does nothing
    #Don't even know why this function is here...
    if user.name
      done = {}
      comp = JSON.parse(user.completion)
      if comp.length > 0
        comp.each do |catkey,catval|
          if catkey
            done[catkey] = {}
            if catval
              catval.each do |stepkey,stepval|
                done[catkey][stepkey] = stepval
              end
            end
          end
        end
        return done
      end
    end
  end

  helper_method :get_activities
  def get_activities
    #Get activities
    @activities = PublicActivity::Activity.order("created_at desc")
  end

  helper_method :get_steps_info
  def get_steps_info(catname, stepname, completion, substepcount)
    #Get info from steps, gets percent done of a step, how many substeps completed of amount
    done = 0
    completion.each do |catkey, catval|
      if catkey == catname
        catval.each do |stepkey, stepval|
          if stepkey == stepname
            stepval.each do |substepkey, substepval|
              if substepval == "done"
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
  def breadcrumbs ##Add breadcrumb function, will return the entire string
    modul = params[:category_name] if params[:category_name]
    step = params[:step_name] if params[:step_name]
    profile = params[:name_url] if params[:name_url]
    home = view_context.link_to "Home", root_path
    edit = if params[:video_name] then params[:video_name] elsif params[:assignment_name] then params[:assignment_name] elsif params[:quiz_name] then params[:quiz_name] elsif params[:guide_name] then params[:guide_name] elsif params[:question_name] then params[:question_name] else false end
      if edit #If editing something << V ery nice
        edit_url = if video_path(edit) then video_path(edit) elsif assignment_path(edit) then assignment_path(edit) elsif quiz_path(edit) then quiz_path(edit) elsif guide_path(edit) then guide_path(edit) elsif question_path(edit) then question_path(edit) else false end
        end
        if params[:action] == 'admin' ##If on admin path
          admin = view_context.link_to 'Admin', admin_path
          return home + " > "+admin
        end
        if params[:action] == 'faqs' ##If on faq path
          faqs = view_context.link_to 'Faq', faq_path
          return home + " > "+faqs
        end
        if profile ##If on profile
          profile_split = params[:name_url].split('/')[0]
          profile_name = profile_split.split('-')[0]
          profilee = view_context.link_to profile_name, user_path
          return home + " > "+profilee
        end
        if edit_url #If edit_url is present
          edit_urlx = view_context.link_to edit, edit_url
          return home +" > "+edit_urlx
        end
        if modul #if on a module
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
