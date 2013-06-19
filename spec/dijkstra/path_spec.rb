require "spec_helper"

describe "Dijkstra::Path" do
  subject {Dijkstra::Path}

  it "should be" do
    subject.should be
  end

  context "bare instance" do
    subject {Dijkstra::Path.new(Dijkstra::Node.new, Dijkstra::Node.new, 10)}

    it "should be an instance of Dijkstra::Path" do
      subject.class.should eq(Dijkstra::Path)
    end
  end
end
