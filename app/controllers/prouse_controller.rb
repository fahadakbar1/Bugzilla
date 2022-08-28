class ProuseController < ApplicationController

  def adddev
     #@prouse = Prouse.new(user_id: 5, project_id: 33)

     #@prouse.save
     @dev= params[:developer_for_this_project]
     @developers = User.with_role :Developer
     @projid=params[:project]
     @developer = @developers.find_by(username:@dev)
     if (Prouse.exists?(Prouse.where(project_id:params[:project], user_id:@developer.id)))
        redirect_to project_path(@projid), notice: "#{@dev} is already the developer of this project"
   else
     Prouse.create(project_id:params[:project], user_id:@developer.id)
     redirect_to project_path(@projid), notice: "Developer #{@dev} has been added to this project"
  end
  end

  def addqa
     #@prouse = Prouse.new(user_id: 5, project_id: 33)

     #@prouse.save
     @qa= params[:qas_for_this_project]
     @qas = User.with_role :QA
     @projid=params[:project]
     @Qa = @qas.find_by(username:@qa)

     if (Prouse.exists?(Prouse.where(project_id:params[:project], user_id:@Qa.id)))
        redirect_to project_path(@projid), notice: "#{@qa} is already the QA of this project"
     else
     Prouse.create(project_id:params[:project], user_id:@Qa.id)
     redirect_to project_path(@projid), notice: "QA #{@qa} has been added to this project"
     end
  end


def removedev
     #@prouse = Prouse.new(user_id: 5, project_id: 33)

     #@prouse.save
     @dev= params[:developer_for_this_project]
     @developers = User.with_role :Developer
     @projid=params[:project]
     @developer = @developers.find_by(username:@dev)

     if (Prouse.exists?(Prouse.where(project_id:params[:project], user_id:@developer.id)))
        Prouse.delete(Prouse.where(project_id:params[:project], user_id:@developer.id))
       redirect_to project_path(@projid), notice: "Developer #{@dev} has been removed from this project"
   else
      redirect_to project_path(@projid), notice: "#{@dev} is not the developer of this project"
    end

  end

  def removeqa
     #@prouse = Prouse.new(user_id: 5, project_id: 33)

     #@prouse.save
     @qa= params[:qas_for_this_project]
     @qas = User.with_role :QA
     @projid=params[:project]
     @Qa = @qas.find_by(username:@qa)

     if (Prouse.exists?(Prouse.where(project_id:params[:project], user_id:@Qa.id)))
        Prouse.delete(Prouse.where(project_id:params[:project], user_id:@Qa.id))
       redirect_to project_path(@projid), notice: "QA #{@qa} has been removed from this project"
   else
      redirect_to project_path(@projid), notice: "#{@qa} is not the QA of this project"
    end
  end

end
