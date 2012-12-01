require 'spec_helper'

describe TopicsHelper do
  describe "intfy_pararams_page!" do
    context "when params[:page] is nil" do
      it "returns integer of params[:page]" do
        helper.intfy_pararams_page!.should eq 1
      end
    end

    context "when params[:page] is 3" do
      it "returns integer of params[:page]" do
        params[:page] = 3
        helper.intfy_pararams_page!.should eq 3
      end
    end

    context "when params[:page] is '3'" do
      it "returns integer of params[:page]" do
        params[:page] = '3'
        helper.intfy_pararams_page!.should eq 3
      end
    end

    context "when params[:page] is -1" do
      it "returns integer of params[:page]" do
        params[:page] = -1
        helper.intfy_pararams_page!.should eq 1
      end
    end

    context "when params[:page] is '-1'" do
      it "returns integer of params[:page]" do
        params[:page] = '-1'
        helper.intfy_pararams_page!.should eq 1
      end
    end
  end
end
