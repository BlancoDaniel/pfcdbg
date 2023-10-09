# frozen_string_literal: true

class CategoryComponent < ViewComponent::Base
  attr_reader :category

  def initialize(category: nil)
    @category = category
  end

  def title
    category ? category.name : t('.all')
  end

  def link
    category ? events_path(category_id: category.id) : events_path
  end

  def active?
    return true if !category && !params[:category_id]
    category&.id == params[:category_id].to_i
  end

  def background
    active? ? "bg-gray-300" : "bg-white"
  end

  def classes
    "category btn btn-light rounded-2xl drop-shadow-sm hover:bg-gray-300 #{background}"
  end
end
