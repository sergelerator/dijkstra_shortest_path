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
      let(:nodes){ subject.nodes }

      context "of first node" do
        let(:neighbours) { nodes[0].neighbours }

        it "has a length of 3" do
          neighbours.length.should eq(3)
        end

        it "has nodes[1] at neighbours[0]" do
          neighbours[0].should eq(nodes[1])
        end

        it "has nodes[5] at neighbours[1]" do
          neighbours[1].should eq(nodes[5])
        end

        it "has nodes[2] at neighbours[2]" do
          neighbours[2].should eq(nodes[2])
        end
      end

      context "of second node" do
        let(:neighbours) { nodes[1].neighbours }

        it "has a length of 3" do
          neighbours.length.should eq(3)
        end

        it "has nodes[0] at neighbours[0]" do
          neighbours[0].should eq(nodes[0])
        end

        it "has nodes[2] at neighbours[1]" do
          neighbours[1].should eq(nodes[2])
        end

        it "has nodes[3] at neighbours[2]" do
          neighbours[2].should eq(nodes[3])
        end
      end
    end

    context "labeling everything from first node" do
      let(:nodes) { subject.nodes }
      before :each do
        subject.label_everything_from(nodes[0])
      end

      it "should label the node at index 0 with a '0'" do
        nodes[0].label.should eq(0)
      end

      it "should label the node at index 1 with a '7'" do
        nodes[1].label.should eq(7)
      end

      it "should label the node at index 2 with a '9'" do
        nodes[2].label.should eq(9)
      end

      it "should label the node at index 3 with a '20'" do
        nodes[3].label.should eq(20)
      end

      it "should label the node at index 5 with a '11'" do
        nodes[5].label.should eq(11)
      end
    end

    describe "shortest_path" do
      let(:nodes) { subject.nodes }

      context "from nodes[0] to nodes[4]" do
        let(:path) { subject.shortest_path(nodes.first, nodes[4]) }

        it "has a length of 4" do
          path.length.should be(4)
        end

        it "has nodes[0] at path[0]" do
          path[0].should be(nodes[0])
        end

        it "has nodes[2] at path[1]" do
          path[1].should be(nodes[2])
        end

        it "has nodes[5] at path[2]" do
          path[2].should be(nodes[5])
        end

        it "has nodes[4] at path[3]" do
          path[3].should be(nodes[4])
        end
      end

      context "from nodes[3] to nodes[5]" do
        let(:path) { subject.shortest_path(nodes[3], nodes[5]) }

        describe "neighbours of nodes[2]" do
          it "has a length of 4" do
            nodes[2].neighbours.length.should be(4)
          end

          it "includes nodes[5]" do
            nodes[2].neighbours.include?(nodes[5]).should be
          end

          it "includes nodes[0]" do
            nodes[2].neighbours.include?(nodes[0]).should be
          end

          it "includes nodes[1]" do
            nodes[2].neighbours.include?(nodes[1]).should be
          end

          it "includes nodes[3]" do
            nodes[2].neighbours.include?(nodes[3]).should be
          end

          it "is nodes[2] at neighbours[1]" do
            nodes[3].neighbours[1].should be(nodes[2])
          end
        end

        describe "neighbours of nodes[3]" do
          it "has a length of 3" do
            nodes[3].neighbours.length.should be(3)
          end

          it "is nodes[1] at neighbours[0]" do
            nodes[3].neighbours[0].should be(nodes[1])
          end

          it "is nodes[2] at neighbours[1]" do
            nodes[3].neighbours[1].should be(nodes[2])
          end
        end

        context "prebuilt path" do
          before :each do
            path
          end

          it "has the label 15 at nodes[1]" do
            nodes[1].label.should be(15)
          end

          it "has the label 11 at nodes[2]" do
            nodes[2].label.should be(11)
          end

          it "has the label 13 at nodes[5]" do
            nodes[5].label.should be(13)
          end
        end

        it "has a length of 3" do
          path.length.should be(3)
        end

        it "has nodes[3] at path[0]" do
          path[0].should be(nodes[3])
        end

        it "has nodes[2] at path[1]" do
          path[1].should be(nodes[2])
        end

        it "has nodes[5] at path[2]" do
          path[2].should be(nodes[5])
        end
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

      context "of first node" do
        let(:neighbours) { nodes[0].neighbours }

        it "has a length of 4" do
          neighbours.length.should eq(4)
        end

        it "has nodes[1] at neighbours[0]" do
          neighbours[0].should eq(nodes[1])
        end

        it "has nodes[5] at neighbours[1]" do
          neighbours[1].should eq(nodes[5])
        end

        it "has nodes[2] at neighbours[2]" do
          neighbours[2].should eq(nodes[2])
        end
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
