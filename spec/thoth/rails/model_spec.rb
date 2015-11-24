require 'spec_helper'
require 'thoth/rails/railtie'

describe Thoth::Rails::Model do
  before(:all) do
    Thoth.logger ||= Thoth::Logger.new(StringIO.new('', 'r+'))
  end

  class Person < ActiveRecord::Base
    include Thoth::Rails::Model
    log_events
  end


  context "on create" do
    it "records the create event" do
      expect(Thoth).to receive(:logger).and_return(double(log: true))
      Person.create(name: 'Lee')
    end

    context "and not recording create events" do
      class Cat < ActiveRecord::Base
        include Thoth::Rails::Model
        log_events on: :update
      end

      it "does not record anything" do
        expect(Thoth).not_to receive(:logger)
        Cat.create!
      end
    end
  end

  context "on destroy" do
    let!(:person) { Person.create(name: 'Lee') }

    it "records the destroy event" do
      expect(Thoth).to receive(:logger).and_return(double(log: true))
      person.destroy
    end

    context "and not recording destroy events" do
      class Cat < ActiveRecord::Base
        include Thoth::Rails::Model
        log_events on: :update
      end

      let!(:cat) { Cat.create }

      it "does not record anything" do
        expect(Thoth).not_to receive(:logger)
        cat.destroy
      end
    end
  end

  context "on update" do
    let!(:person) { Person.create(name: 'Lee') }

    it "records the update event" do
      expect(Thoth).to receive(:logger).and_return(double(log: true))
      person.update_attributes!(name: 'Smith')
    end

    context "when logging only changes to certain attribute" do
      class PersonWithOnly < Person
        include Thoth::Rails::Model
        log_events only: :name
      end

      let!(:person) { PersonWithOnly.create(name: 'Lee') }


      context "and a watched attribute changes" do
        it "records the update event" do
          expect(Thoth).to receive(:logger).and_return(double(log: true))
          person.update_attributes!(name: 'Smith', color: :blue)
        end
      end

      context "and a watched attribute does not change" do
        it "does not record anything" do
          expect(Thoth).not_to receive(:logger)
          person.update_attributes!(color: :blue)
        end
      end
    end

    context "and not recording update events" do
      class Car < ActiveRecord::Base
        include Thoth::Rails::Model
        log_events on: :destroy
      end

      let!(:car) { Car.create(make: 'Tesla', model: 'S') }

      it "does not record anything" do
        expect(Thoth).not_to receive(:logger)
        car.update_attributes!(model: 'X')
      end
    end
  end
end
