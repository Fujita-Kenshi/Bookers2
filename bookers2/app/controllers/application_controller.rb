class ApplicationController < ActionController::Base
    
    # sign_inしていない状態でtop-page,about以外の画面にアクセスしても、log_in-pageへリダイレクトされる。
    before_action :authenticate_user!, except: [:top, :about]
    
    # devise利用の機能（ユーザ登録、ログイン認証など）が行われる前にconfigure_permitted_parametersメソッドを実行する
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    
    def after_sign_in_path_for(resource)    # resourceにユーザーのデータが格納される。
        user_path(resource)
    end
    
    
    def after_sign_out_path_for(resource)
        # flash[:notice] = "Signed out successfully."
        root_path
    end
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
        ## configでemailをnameにしたことによって、deviseの初期機能であったemailの保存機能が失っているため、
        # sign_upを実施したときに、email can't be blank のエラーが発生する。
        # そこでkeyにemailを記述しすると保存機能を付与できる。要は追加する。
        ## devise_parameter_sanitizerメソッドを使うことで、ユーザ登録時(sign_up)に、ユーザ名(name)のデータ操作を許可する
        # 初期のdevise_controllerではユーザ名(nameカラム)を登録できない。
        # sign_up,sign_in時のみ操作できれば良いので、ストロングパラメータ下に以下を記述する。
    end
    
end
    ## フラッシュメッセージの
    # add_flash_types :success, :info, :warning, :danger
    

    ## deviseにフラッシュメッセージの機能が備わっているため、記述の必要なし。
    
    # def after_sign_up_path_for(resource)    # resourceにユーザーのデータが格納される。
    #     user_path(resource)
    # end

    # def after_sign_in_path_for(resource)    # resourceにユーザーのデータが格納される。
    #     if current_user
    #         flash[:notice] = "Signed in successfully."
    #         user_path(resource)
    #     else
    #         flash[:notice] = "Welcome! You have signed up successfully."
    #         user_path(resource)
    #         # user_path(resource)
    #     end
    # end