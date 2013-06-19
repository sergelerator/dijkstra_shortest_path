require "spec_helper"

describe Dijkstra::Node do
  it "should be" do
    subject.should be
  end

  context "bare instance" do
    subject {Dijkstra::Node.new}

    it "should be an instance of Dijkstra::Node" do
      subject.class.should eq(Dijkstra::Node)
    end
  end

  describe "set_label" do
    let(:visitor) { Dijkstra::Node.new }

    before :each do
      subject.reset
    end

    context "when label is Infinity" do
      before :each do
        subject.label = Dijkstra::Infinity
      end

      it "sets distance_to_this_node to label" do
        subject.set_label(visitor, 42)
        subject.label.should eq(42)
      end

      it "sets the previous node to 'visitor'" do
        subject.set_label(visitor, 42)
        subject.previous_node.should be(visitor)
      end
    end

    context "when distance_to_this_node is less than label" do
      before :each do
        subject.label = 70
      end

      it "sets distance_to_this_node to label" do
        subject.set_label(visitor, 7)
        subject.label.should eq(7)
      end

      it "sets the previous node to 'visitor'" do
        subject.set_label(visitor, 7)
        subject.previous_node.should be(visitor)
      end
    end

    context "when distance_to_this_node is more than label" do
      before :each do
        subject.label = 7
      end

      it "doesn't set distance_to_this_node to label" do
        subject.set_label(visitor, 35)
        subject.label.should eq(7)
      end

      it "doesn't set a previous node, visitor is ignored" do
        subject.previous_node = winner = Dijkstra::Node.new
        subject.set_label(visitor, 35)
        subject.previous_node.should be(winner)
      end
    end
  end

  describe "neighbours" do

    context "when 4 neighbours exist" do
      before :each do
        subject.reset

        subject.instance_eval do
          @paths = []
          4.times do
            @paths << Dijkstra::Path.new(self, Dijkstra::Node.new, 4)
          end
        end
      end

      it "returns 4 nodes" do
        subject.neighbours.length.should eq(4)
      end

      it "returns objects of class Dijkstra::Node" do
        subject.neighbours.each do |n|
          n.class.should be(Dijkstra::Node)
        end
      end

      it "sets the path to reach a node to each returned node" do
        subject.neighbours.map(&:path).each do |n|
          n.class.should be(Dijkstra::Path)
        end
      end

      describe "paths's end" do
        let(:neighbours) { subject.neighbours }

        before :each do
          @node_1 = Dijkstra::Node.new
          @node_2 = Dijkstra::Node.new
          @path_1 = Dijkstra::Path.new(subject, @node_1, 15)
          @path_2 = Dijkstra::Path.new(subject, @node_2, 5)

          @node_1.paths << @path_1
          @node_2.paths << @path_2

          subject.instance_eval{ @paths = [] }

          subject.paths << @path_1
          subject.paths << @path_2
        end

        it "has node_1 at neighbours[0]" do
          neighbours[0].should be(@node_1)
        end

        it "has node_2 at neighbours[1]" do
          neighbours[1].should be(@node_2)
        end

        it "has subject at node_1's neighbours[0]" do
          @node_1.neighbours[0].should be(subject)
        end

        it "has subject at node_2's neighbors[0]" do
          @node_2.neighbours[0].should be(subject)
        end
      end
    end

  end

  describe "measure_neighbours_distance" do
    let(:visitor) { Dijkstra::Node.new }

    context "when subject is source" do

      context "when source has 3 unvisited_neighbours" do
        before :each do
          subject.reset

          subject.instance_eval { @paths = [] }
          subject.paths << Dijkstra::Path.new(subject, Dijkstra::Node.new, 7)
          subject.paths << Dijkstra::Path.new(subject, Dijkstra::Node.new, 8)
          subject.paths << Dijkstra::Path.new(subject, Dijkstra::Node.new, 9)
          subject.label = 0

          subject.measure_neighbours_distance
        end

        it "should label first neighbour with 7" do
          subject.neighbours[0].label.should eq(7)
        end

        it "should label second neighbour with 8" do
          subject.neighbours[1].label.should eq(8)
        end

        it "should label third neighbour with 9" do
          subject.neighbours[2].label.should eq(9)
        end

      end

    end

  end
end
