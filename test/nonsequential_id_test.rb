require 'test/unit'
require 'mocha/test_unit'

require 'sequel'
require 'timeout'

require_relative '../lib/sequel/plugins/nonsequential_id'

DB = Sequel.sqlite

DB.create_table :test_models do
  primary_key :id, type: String, auto_increment: false
  String :name, unique: true
end

DB.create_table :test_model2s do
  primary_key :custom_id, type: String, auto_increment: false
  String :name
end

class TestModel < Sequel::Model
  plugin :nonsequential_id
end

class TestModel2 < Sequel::Model
  plugin :nonsequential_id, id_field: :custom_id
end

class NonsequentialIdTest < Test::Unit::TestCase
  def setup

  end

  def teardown
    DB[:test_models].delete
    DB[:test_model2s].delete
  end

  def test_nonsequential_id
    obj1 = TestModel.create(name: 'obj1')
    obj2 = TestModel.create(name: 'obj2')

    assert_kind_of String, obj1.id
    assert_kind_of String, obj2.id

    assert_not_empty obj1.id
    assert_not_empty obj2.id

    assert_not_equal obj1.id, obj2.id

    assert_equal(obj1.id, TestModel.first(id: obj1.id).id)
    assert_equal(obj2.id, TestModel.first(id: obj2.id).id)
  end

  def test_nonsequential_id_custom_field
    obj1 = TestModel2.create(name: 'obj1')
    obj2 = TestModel2.create(name: 'obj2')

    assert_kind_of String, obj1.custom_id
    assert_kind_of String, obj2.custom_id

    assert_not_empty obj1.custom_id
    assert_not_empty obj2.custom_id

    assert_not_equal obj1.custom_id, obj2.custom_id

    assert_equal(obj1.custom_id, TestModel2.first(custom_id: obj1.custom_id).custom_id)
    assert_equal(obj2.custom_id, TestModel2.first(custom_id: obj2.custom_id).custom_id)
  end

  def test_duplicate_id
    SecureRandom.stubs(:hex).returns('a', 'a', 'b')
    obj1 = TestModel.create(name: 'obj1')
    obj2 = nil

    Timeout::timeout(1) do
      obj2 = TestModel.create(name: 'obj2')
    end

    assert_equal 'a', obj1.id
    assert_equal 'b', obj2.id
  end

  def test_duplicate_other
    TestModel.create(name: 'obj1')
    assert_raise(Sequel::UniqueConstraintViolation){TestModel.create(name: 'obj1')}
  end
end