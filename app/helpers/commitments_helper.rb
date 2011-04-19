module CommitmentsHelper
 
    def uncommittable_user
      @undertaking = Commitment.find(params[:id]).undertaking
      Commitment.find_by_undertaking_id_and_user_id(@undertaking, current_user).roles.include?("owner") || correct_user
    end
end
