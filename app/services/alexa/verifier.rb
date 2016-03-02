class Alexa::Verifier
  def self.verify(headers:, body:)
    AlexaVerifier.new.verify!(
      headers['SignatureCertChainUrl'],
      headers['Signature'],
      body
    )
  end
end
