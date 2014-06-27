 FactoryGirl.define do

   factory :ouath_application, class: Doorkeeper::Application do
     name 'test'
     redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
     uid '89677de1dcb5a8557b147981116467b187bee7bc2886ddb450cdc0475f5e26b7'
     secret 'ffcf6c4a04ab3f4e2f5e526308722ad267ff671c78d84c2224b3691e6ad88747'
   end
 end