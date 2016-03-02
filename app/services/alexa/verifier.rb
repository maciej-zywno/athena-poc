class Alexa::Verifier
  def self.verify(signature:, signature_url:, body:)
    AlexaVerifier.new.verify!(signature_url, signature, body)
  end
end