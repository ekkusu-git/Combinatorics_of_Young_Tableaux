require 'test/unit'
require_relative "Partition"

class Tester < Test::Unit::TestCase
	def test_transpose
		assert_equal Partition.new([]), Partition.new([]).transpose
		assert_equal Partition.new([1]), Partition.new([1]).transpose
		assert_equal Partition.new([4,4,3,1,1]), Partition.new([5,3,3,2]).transpose
		assert_equal Partition,Partition.new([5,3,3,2]).transpose.class
	end
	def test_addition
		assert_equal [6,4,2].to_partition,[3,2,1].to_partition + [3,2,1].to_partition
		assert_equal Partition,([3,2,1].to_partition + [3,2,1].to_partition).class
	end
	def test_concat
		assert_equal [3,3,2,2,1,1].to_partition,[3,2,1].to_partition.concat([3,2,1].to_partition)
		assert_equal Partition,[3,2,1].to_partition.concat([3,2,1].to_partition).class
	end
	def test_set
		assert_equal [[].to_partition], Partition.set(0)
		assert_equal [[1].to_partition], Partition.set(1)
		assert_equal [[2].to_partition,[1,1].to_partition], Partition.set(2)
		assert_equal [[3].to_partition,[2,1].to_partition,[1,1,1].to_partition], Partition.set(3)
	end
	def test_outer_corners_indices
		assert_equal [0], [].to_partition.outer_corners_indices
		assert_equal [0,1], [1].to_partition.outer_corners_indices
		assert_equal [0,2,4], [4,4,2,2].to_partition.outer_corners_indices
	end
	def test_set_plus_horizontal_strip_of_size
		assert_equal [[3].to_partition], [].to_partition.set_plus_horizontal_strip_of_size(3)
		assert_equal [
			[7,2,1].to_partition,
			[6,3,1].to_partition,
			[6,2,2].to_partition,
			[6,2,1,1].to_partition,
			[5,4,1].to_partition,
			[5,3,2].to_partition,
			[5,3,1,1].to_partition,
			[5,2,2,1].to_partition,
			[4,4,2].to_partition,
			[4,4,1,1].to_partition,
			[4,3,2,1].to_partition
		].sort, [4,2,1].to_partition.set_plus_horizontal_strip_of_size(3).sort
	end
	def test_set_minus_horizontal_strip_of_size
		assert_equal [[].to_partition], [3].to_partition.set_minus_horizontal_strip_of_size(3)
		assert_equal [
			[4,1].to_partition,
			[3,2].to_partition,
			[3,1,1].to_partition,
			[2,2,1].to_partition
		].sort, [4,2,1].to_partition.set_minus_horizontal_strip_of_size(2).sort
	end
	def test_set_plus_vertical_strip_of_size
		assert_equal [[1,1,1].to_partition], [].to_partition.set_plus_vertical_strip_of_size(3)
		assert_equal [
			[4,2,1,1,1,1].to_partition,
			[4,2,2,1,1].to_partition,
			[4,3,1,1,1].to_partition,
			[5,2,1,1,1].to_partition,
			[4,3,2,1].to_partition,
			[5,2,2,1].to_partition,
			[5,3,1,1].to_partition,
			[5,3,2].to_partition
		].sort,[4,2,1].to_partition.set_plus_vertical_strip_of_size(3).sort
	end
	def test_set_misus_vertical_strip_of_size
		assert_equal [], [1,1,1].to_partition.set_minus_vertical_strip_of_size(4)
		assert_equal [[].to_partition], [1,1,1].to_partition.set_minus_vertical_strip_of_size(3)
		assert_equal [
			[2,2].to_partition,
			[2,1,1].to_partition,
			[1,1,1,1].to_partition
		].sort,[2,2,1,1].to_partition.set_minus_vertical_strip_of_size(2).sort
	end
end
