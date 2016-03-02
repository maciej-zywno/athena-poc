require 'spec_helper'

describe Alexa::Verifier do

  describe '.verify' do
    let(:alexa_verifier) { instance_double(AlexaVerifier) }

    before { expect(AlexaVerifier).to receive(:new) { alexa_verifier } }

    context 'when data is valid' do
      let(:headers) { { 'Signature': 'signature', 'SignatureCertChainUrl': 'signature_url', } }
      let(:body) { '{"body":"value"}' }

      it 'verifies requests' do
        expect(alexa_verifier).to receive(:verify!).with(
          headers['SignatureCertChainUrl'],
          headers['Signature'],
          body
        ) { true }

        expect(Alexa::Verifier.verify(body: body, headers: headers)).to eq true
      end
    end

    context 'when data is invalid' do
      let(:headers) { { 'Signature': 'invalid_signature', 'SignatureCertChainUrl': 'invalid_signature_url', } }
      let(:body) { '{"body":"invalid_value"}' }

      it 'raise AlexaVerifier::VerificationError' do
        expect(alexa_verifier).to receive(:verify!).with(
          headers['SignatureCertChainUrl'],
          headers['Signature'],
          body
        ) { raise AlexaVerifier::VerificationError }

        expect { Alexa::Verifier.verify(body: body, headers: headers) }
          .to raise_error(AlexaVerifier::VerificationError)
      end
    end
  end
end
