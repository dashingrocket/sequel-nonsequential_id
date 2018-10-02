require 'test/unit'
require 'sequel'

require_relative '../lib/sequel/plugins/unique_id'

DB = Sequel.sqlite

DB.create_table :test_models do
  primary_key :id, type: String, auto_increment: false
  String :name
end

DB.create_table :test_model2s do
  primary_key :custom_id, type: String, auto_increment: false
  String :name
end

class TestModel < Sequel::Model
  plugin :unique_id
end

class TestModel2 < Sequel::Model
  plugin :unique_id, id_field: :custom_id
end

class UniqueIDTest < Test::Unit::TestCase
  def setup

  end

  def test_unique_id
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

  def test_test_unique_id_custom_field
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
end