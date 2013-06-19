require "spec_helper"

describe Dijkstra::Graph do
  it "should be" do
    subject.should be
  end

  context "bare instance" do
    subject {Dijkstra::Graph.new}

    it "should be an instance of Dijkstra::Graph" do
      subject.class.should eq(Dijkstra::Graph)
    end
  end

  context "Wikipedia example" do
    before :each do
      subject.clear
      6.times { subject.add_node(Dijkstra::Node.new) }
      ns = subject.nodes
      subject.link_nodes(ns[0], ns[1],  7)
      subject.link_nodes(ns[0], ns[5], 14)
      subject.link_nodes(ns[0], ns[2],  9)
      subject.link_nodes(ns[1], ns[2], 10)
      subject.link_nodes(ns[1], ns[3], 15)
      subject.link_nodes(ns[2], ns[3], 11)
      subject.link_nodes(ns[2], ns[5],  2)
      subject.link_nodes(ns[3], ns[4],  6)
      subject.link_nodes(ns[5], ns[4],  9)
    end

    describe "neighbours" do
      let(:nodes){subject.nodes}

      it "should return all the set neighbours of first node" do
        s = nodes[0].neighbours
        s.length.should eq(3)
        s[0].should eq(nodes[1])
        s[1].should eq(nodes[5])
        s[2].should eq(nodes[2])
      end

      it "should return all the set neighbours of second node" do
        s = nodes[1].neighbours
        s.length.should eq(3)
        s[0].should eq(nodes[0])
        s[1].should eq(nodes[2])
        s[2].should eq(nodes[3])
      end
    end

    context "labeling everything from first node" do
      before :each do
        subject.label_everything_from(subject.nodes[0])
      end

      it "should label the node at index 0 with a '0'" do
        subject.nodes[0].label.should eq(0)
      end

      it "should label the node at index 1 with a '7'" do
        subject.nodes[1].label.should eq(7)
      end

      it "should label the node at index 2 with a '9'" do
        subject.nodes[2].label.should eq(9)
      end

      it "should label the node at index 3 with a '20'" do
        subject.nodes[3].label.should eq(20)
      end

      it "should label the node at index 5 with a '11'" do
        subject.nodes[5].label.should eq(11)
      end
    end
  end

  context "extended Wikipedia example" do
    before :each do
      subject.clear
      8.times { subject.add_node(Dijkstra::Node.new) }
      ns = subject.nodes
      subject.link_nodes(ns[0], ns[1],  7)
      subject.link_nodes(ns[0], ns[5], 14)
      subject.link_nodes(ns[0], ns[2],  9)
      subject.link_nodes(ns[1], ns[2], 10)
      subject.link_nodes(ns[1], ns[3], 15)
      subject.link_nodes(ns[2], ns[3], 11)
      subject.link_nodes(ns[2], ns[5],  2)
      subject.link_nodes(ns[3], ns[4],  6)
      subject.link_nodes(ns[5], ns[4],  9)

      subject.link_nodes(ns[0], ns[7],  1)
      subject.link_nodes(ns[5], ns[6],  4)
      subject.link_nodes(ns[5], ns[7], 24)
    end

    describe "neighbours" do
      let(:nodes){subject.nodes}

      it "should return all the set neighbours of first node" do
        s = nodes[0].neighbours
        s.length.should eq(4)
        s[0].should eq(nodes[1])
        s[1].should eq(nodes[5])
        s[2].should eq(nodes[2])
      end

      it "should return all the set neighbours of second node" do
        s = nodes[1].neighbours
        s.length.should eq(3)
        s[0].should eq(nodes[0])
        s[1].should eq(nodes[2])
        s[2].should eq(nodes[3])
      end
    end

    context "labeling everything from first node" do
      before :each do
        subject.label_everything_from(subject.nodes[0])
      end

      it "should label the node at index 0 with a '0'" do
        subject.nodes[0].label.should eq(0)
      end

      it "should label the node at index 1 with a '7'" do
        subject.nodes[1].label.should eq(7)
      end

      it "should label the node at index 2 with a '9'" do
        subject.nodes[2].label.should eq(9)
      end

      it "should label the node at index 3 with a '20'" do
        subject.nodes[3].label.should eq(20)
      end

      it "should label the node at index 4 with a '20'" do
        subject.nodes[4].label.should eq(20)
      end

      it "should label the node at index 5 with a '11'" do
        subject.nodes[5].label.should eq(11)
      end

      it "should label the node at index 6 with a '15'" do
        subject.nodes[6].label.should eq(15)
      end

      it "should label the node at index 7 with a '1'" do
        subject.nodes[7].label.should eq(1)
      end
    end
  end
end
