// Mutaciones
String userAuth = '''
      mutation AuthenticationUser(\$email: String!, \$pass: String!){
      tokenAuth(email: \$email, password: \$pass) {
         success,
          errors,
          unarchiving,
          token,
          refreshToken,
          unarchiving,
          user {
              id,
              username,
              email,
              verified,
              pk,
              profileImage
              }
            }
         }
      ''';

String registerUser = '''
      mutation RegisterUser(\$email: String!, \$password: String!){
          register(
              email: \$email,
              username: \$email,
              password1: \$password,
              password2: \$password,
          ) {
              success,
              errors,
              token,
              refreshToken
          }
      }
      ''';

String resendActivationEmail = '''
      mutation ResendEmailActivateAccount(\$email: String!){
        resendEmailActivateAccount(input:{email:\$email})
        {
          success,
          error
        }
      }
  ''';

String ActivateAccount = '''
      mutation ActivateAccount (\$code:Int!) {
        activateAccount(input:{code:\$code}){
          success,
          error
        }
      }
  ''';

String ResetPasswordCode = '''
      mutation SendPasswordResetEmail(\$email:String!) {
        sendPasswordResetEmail(input:{email:\$email}){
          success,
          error
        }
      }     
  ''';

String SetNewPassword = '''
      mutation ResetPasswordEmail(\$code:Int!, \$password1:String!, \$password2:String!){
        resetPasswordEmail(input:{code:\$code, password1:\$password1, password2:\$password2}){
          success,
          error
        }
      }
  ''';

String getallBeneficiary = '''
        query AllBeneficiary {
            allBeneficiary{
              code,
              list  {
                id,
                name,
                numberAccount,
                email,
                bank {
                  id,
                  name,
                  swiftCode,
                }
                phone,
                image
            }
          }
        }
  ''';

String getallTransfer = '''
query AllTransfer {
          allTransfer {
           code,
           list {
            id,
            refTX,
            refMerchant,
            refBank,
            amount,
            status,
            date,
            note,
            paymentLink,
            beneficiary {
              id,
              name,
              numberAccount,
              bank {
                id,
                name,
                swiftCode,
              }
              phone,
              email,
              image
              }
            }
          }
        }
  ''';

String addBeneficiary = '''
mutation CreateBeneficiary(
      \$name: String!, 
      \$numberAccount: String!, 
      \$email: String!, 
      \$phone: String!, 
      \$bankId: ID!,){
  createBeneficiary(
    input:{
      name: \$name,
      numberAccount: \$numberAccount,
      email: \$email,
      phone: \$phone,
      bank: \$bankId,
    }){
    beneficiaryNode{
      id
      name
    }
    success
    error
  }
}
  ''';

String delBeneficiary = '''
      mutation DeleteBeneficiary(\$id:ID!){
        deleteBeneficiary(input:{id:\$id}){
          success,
          error
        }
      }
  ''';

String updateBeneficiary = '''
      mutation UpdateBeneficiary(
        \$id: ID!, 
        \$name: String!, 
        \$numberAccount: String!, 
        \$email: String!, 
        \$phone: String!, 
        \$bankId: ID!
      ){
          updateBeneficiary(input:{
            id:\$id,
            name:\$name,
            email:\$email,
            phone:\$phone,
            numberAccount:\$numberAccount,
            bank:\$bankId
          }){
          beneficiaryNode{
            id
            name
          }
            success,
            error
          }
      }
  ''';

String getKyc = '''
      query getKyc{
        getKyc{
          code,
          list {
            id,
            name,
            lastname,
            dni,
            postaddress,
            postcode,
            phone,
            status,
            city,
            state,
            country,
            imageIdentity,
            imageAddress
          }
        }
      }
  ''';

String updateKyc = '''
      mutation updateKyc(\$id: ID!, \$name: String, \$lastname: String, \$dni: String,
      \$postaddress: String, \$postcode: String, \$phone: String, \$city: String,
      \$state: String, \$country: String, \$imageIdentity: Upload, \$imageAddress: Upload){
        updateKyc(input:{
          id:\$id, 
          name:\$name, 
          lastname:\$lastname, 
          dni:\$dni,
          postaddress:\$postaddress, 
          postcode:\$postcode,
          phone:\$phone,
          city:\$city,
          state:\$state,
          country:\$country,
          imageIdentity:\$imageIdentity,
          imageAddress:\$imageAddress
        }){
          success,
          error
        }
      }
  ''';

String createKYC = '''
      mutation createKyc(\$name: String!, \$lastname: String!, \$dni: String!,
      \$postaddress: String!, \$postcode: String!, \$phone: String!, \$city: String!,
      \$state: String!, \$country: String!, \$imageIdentity: Upload!, \$imageAddress: Upload!){
        createKyc(input:{
          name:\$name, 
          lastname:\$lastname, 
          dni:\$dni,
          postaddress:\$postaddress, 
          postcode:\$postcode,
          phone:\$phone,
          city:\$city,
          state:\$state,
          country:\$country,
          imageIdentity:\$imageIdentity,
          imageAddress:\$imageAddress
        }){
          success,
          error
        }
      }
  ''';

String addTransfer = '''
        mutation CreateTransfer(\$beneficiary:ID!, \$amount:Float!, \$note:String!){
                createTransfer(input:{
                  beneficiary:\$beneficiary
                  amount:\$amount,
                  note:\$note,
                }){
                transferNode{
                    id,
                    refTX,
                    refMerchant,
                    refBank,
                    amount,
                    status,
                    date,
                    note,
                    paymentLink,
                    beneficiary{
                      id,
                      name,
                      numberAccount,
                      bank {
                        id,
                        name,
                        swiftCode,
                      }
                      phone,
                      image,
                      email,
                    }
                }
                  success,
                  error
                }
              }
  ''';

String updateTransfer = '''
        mutation UpdateTransfer(\$id:ID!,\$beneficiary:ID, \$bank:ID, \$ref:String, \$amount:Float, \$date:String, \$note:String){
                updateTransfer(input:{id:\$id,beneficiary:\$beneficiary, bank:\$bank, ref:\$ref, amount:\$amount, date:\$date, note:\$note}){
                  transferNode{
                    id,
                    refTX,
                    refMerchant,
                    refBank,
                    amount,
                    status,
                    date,
                    note,
                    beneficiary{
                      id,
                      name
                    }
                    bank{
                      id
                      name
                      swiftCode
                    }
                  },
                  success,
                  error
                }
              }
  ''';

String cancelTranfer = '''
        mutation UpdateTransfer(\$id:ID!){
                updateTransfer(input:{id:\$id, status:"C"}){
                  success,
                  error
                }
              }
  ''';

String delTransfer = '''
      mutation DeleteTransfer(\$id:ID!){
        deleteTransfer(input:{id:\$id}){
          success,
          error
        }
      }
  ''';

String getallBank = '''
        query AllBank {
            allBank{
              code,
              list {
                id,
                name,
                swiftCode
            }
          }
        }
  ''';

String updateImageIdentityKyc = '''
        mutation UpdateImageIdentityKyc(\$id:ID!,\$file:Upload!){
          updateImageIdentityKyc(input:{
            id:\$id,
            imageIdentity:\$file,
          }){
            success,
            error
          }
        }
  ''';

String updateImageBeneficiary = '''
        mutation updateBeneficiary(\$id:ID!,\$file:Upload!) {
          updateBeneficiary(input:{
            id:\$id,
            image:\$file,
          }){
            success,
            error
          }
        }
''';

String updateImageAddressKyc = '''
        mutation UpdateImageAddressKyc(\$id:ID!,\$file:Upload!){
          updateImageAddressKyc(input:{
            id:\$id,
            imageAddress:\$file,
          }){
            success,
            error
          }
        }
  ''';

String updateImageProfile = '''
        mutation UpdateImageProfile(
          \$id:ID!,\$file:Upload){
              updateImageProfile(input:{
                id:\$id,
                image:\$file,
              }){
              userNode{
                id,
                username,
                profileImage
                }
                success,
                error
              }
          }
  ''';
