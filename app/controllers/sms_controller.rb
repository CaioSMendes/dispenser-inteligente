class SmsController < ApplicationController
    require 'nexmo'
    require 'twilio-ruby'
  
    def send_sms
      client = Nexmo::Client.new(
        api_key: 'df7e5a45',
        api_secret: 'FgfEdgK6XGK3DulB'
      )
  
      from = '5561995762787' # Seu número de telefone como remetente
      to = '5561995762787' # Número de telefone do destinatário
      #to = '5561992488131' # Número de telefone do destinatário
  
      response = client.sms.send(
        from: from,
        to: to,
        text: 'Olá! Esta é uma mensagem teste do sistema D.I.U informando que sua cachaça está chegando ao fim! Peça para seu distribuidor uma reposição.'
      )
  
      if response.messages.first.status == '0'
        puts 'Mensagem enviada com sucesso!'
      else
        puts 'Erro ao enviar a mensagem.'
      end
    end
  
    def send_whatsapp_message
      url = 'https://api.nexmo.com/v0.1/messages'
  
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => 'Bearer df7e5a45'
      }
  
      payload = {
        from: { type: 'whatsapp', number: '5561995762787' },
        to: { type: 'whatsapp', number: '5561995762787' },
        message: {
          content: {
            type: 'text',
            text: 'Olá! Esta é uma mensagem de teste do Nexmo.'
          }
        }
      }
  
      response = HTTParty.post(url, headers: headers, body: payload.to_json)
  
      if response.code == 200
        # Mensagem enviada com sucesso
        flash[:success] = 'Mensagem enviada via WhatsApp!'
      else
        # Ocorreu um erro ao enviar a mensagem
        flash[:error] = 'Erro ao enviar a mensagem via WhatsApp!'
      end
  
      #redirect_to root_path
    end
  
    def send_sms_twilio
      account_sid = 'ACcbd199f02e7c1e843cd953a16ac1e714'
      auth_token = '3d1102aa17ee4151b2de70dcce93192c'
      client = Twilio::REST::Client.new(account_sid, auth_token)
  
      from = '5416128239' # Número de telefone fornecido pela Twilio
      #to = '5561992488131' # Número de telefone do destinatário Luis RFID
      #to = '5561998058131'
      to = '5561995762787' # Número de telefone do destinatário Caio
      #to = '5561993212899' #Caian
      #to = '5561991150833' #Ivanice
      body = 'Olá! Esta é uma mensagem teste do sistema D.I.U informando que sua cachaca está chegando ao fim! Peça para seu distribuidor uma reposição.' # Corpo da mensagem SMS
  
      message = client.messages.create(
        from: from,
        to: to,
        body: body
      )

        # Save the log entry
        sms_log = SmsLog.create(
            from_number: message.from,
            to_number: message.to,
            body: message.body,
            sent_at: Time.now
        )

        render json: { message: 'SMS sent successfully!' }
        rescue Twilio::REST::TwilioError => e
        render json: { error: e.message }, status: :unprocessable_entity
    end

    def send_whatsapp_message_twilio
        account_sid = 'ACcbd199f02e7c1e843cd953a16ac1e714'
        auth_token = '3d1102aa17ee4151b2de70dcce93192c'
        @client = Twilio::REST::Client.new(account_sid, auth_token)
        
        message = @client.messages.create(
          body: 'Olá! Esta é uma mensagem teste do sistema D.I.U informando que sua cachaça está chegando ao fim! Peça para seu distribuidor uma reposição.',
          from: 'whatsapp:+14155238886',
          to: 'whatsapp:+556195762787', # Caio
          #to: 'whatsapp:+5561992488131' # Luis RFID
          #to: 'whatsapp:+5561993212899' # Caian
        )    
        if message.error_code.nil?
          render json: { message: 'Mensagem enviada com sucesso!' }
        else
          render json: { error: 'Erro ao enviar a mensagem.' }, status: :unprocessable_entity
        end
      end

      def index
        @sms_logs = SmsLog.all
      end
  end
  