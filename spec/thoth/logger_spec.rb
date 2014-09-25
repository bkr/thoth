require 'spec_helper'

describe Thoth::Logger do

  describe '#log' do
    let(:output) { StringIO.new('', 'r+') }
    let(:logger) { Thoth::Logger.new(output) }

    it "writes log to given output" do
      logger.log('checkout')
      expect(output.string).to include('checkout')
    end

    it "includes timestamp" do
      Timecop.freeze('2014-01-03 2:15:09 UTC') do
        logger.log('checkout')
        expect(output.string).to include(':time=>"03/Jan/2014:02:15:09 +0000"')
      end
    end

    context "and Thoth.context contains data" do
      before do
        Thoth.context = {source: :api}
      end

      after do
        Thoth.clear_context!
      end

      it "includes the context" do
        logger.log('checkout')

        expect(output.string).to include(':context=>{:source=>:api}')
      end

      context "and context data passed to #log" do
        it "merges the context data into the log" do
          logger.log('checkout', {}, customer: 1)
          expect(output.string).to include(':context=>{:source=>:api, :customer=>1}')
        end
      end
    end

    context "with details and context" do
      it "includes the details in the log" do
        logger.log('checkout', {total: 2399}, customer: 1)
        expect(output.string).to include(':context=>{:customer=>1}')
      end

      it "includes the context in the log" do
        logger.log('checkout', {total: 2399}, customer: 1)
        expect(output.string).to include(':details=>{:total=>2399}')
      end
    end

    context "with custom timestamp format" do
      let(:logger) { Thoth::Logger.new(output, timestamp_format: '%Y-%m-%d') }

      it "records timestamp with given format" do
        Timecop.freeze('2014-01-03 2:15:09 UTC') do
          logger.log('checkout')
          expect(output.string).to include(':time=>"2014-01-03"')
        end
      end
    end

    context "with custom timestamp key" do
      let(:logger) { Thoth::Logger.new(output, timestamp_key: 'timestamp') }

      it "records timestamp with given format" do
        Timecop.freeze('2014-01-03 2:15:09 UTC') do
          logger.log('checkout')
          expect(output.string).to include('"timestamp"=>"03/Jan/2014:02:15:09 +0000"')
        end
      end
    end
  end

end