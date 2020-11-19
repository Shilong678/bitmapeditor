# frozen_string_literal: true

require File.expand_path 'bitmap_command.rb', __dir__
require File.expand_path 'bitmap_error.rb', __dir__

class BitmapEditor
  include BitmapCommand
  include BitmapError
  attr_accessor :matrix, :matrix_row, :matrix_column

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    first_line = File.open(file, &:readline)
    if check_first_line(first_line)
      read_command(file)
    else
      puts 'Your first line should start with I to create a matrix'
    end
  end

  private

  def read_command(file)
    File.open(file).each do |line|
      line = line.chomp
      a = line.scan(/\w+/)
      case line
      when /^I\s\d+\s\d+$/
        create_matrix(a)
      when /^C$/
        clear(matrix)
      when /^L\s\d+\s\d+\s\w$/
        colour_matrix(a, line)
      when /^V\s\d+\s\d+\s\d+\s\w$/
        verticalize(a, line)
      when /^H\s\d+\s\d+\s\d+\s\w$/
        horizontalize(a, line)
      when /^S$/
        show_matrix(matrix)
      else
        puts 'unrecognised command :('
      end
    end
  end

  def create_matrix(a)
    @matrix_row = a[1].to_i
    @matrix_column = a[2].to_i
    @matrix = create(matrix_row, matrix_column)
  end

  def colour_matrix(a, line)
    row_error?(a[1].to_i, matrix_row, line)
    column_error?(a[2].to_i, matrix_column, line)
    colour(a[1].to_i, a[2].to_i, a[3], matrix)
  rescue StandardError => e
    puts e.message
  end

  def verticalize(a, line)
    row_error?(a[1].to_i, matrix_row, line)
    column_error?(a[3].to_i, matrix_column, line)
    vertical_draw(a[1].to_i, a[2].to_i, a[3].to_i, a[4], matrix)
  rescue StandardError => e
    puts e.message
  end

  def horizontalize(a, line)
    row_error?(a[2].to_i, matrix_row, line)
    column_error?(a[3].to_i, matrix_column, line)
    horizontal_draw(a[1].to_i, a[2].to_i, a[3].to_i, a[4], matrix)
  rescue StandardError => e
    puts e.message
  end
end
