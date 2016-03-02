class Alexa::Verifier
  def self.verify(request:)
    AlexaVerifier.new.verify!(
      request.headers['SignatureCertChainUrl'],
      request.headers['Signature'],
      request.body.read
    )
  end
end
