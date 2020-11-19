# frozen_string_literal: true

module BitmapCommand
  def create(row, column)
    Array.new(column) { Array.new(row, 'O') }
  end

  def clear(matrix)
    matrix.each do |table|
      table.map! { 'O' }
    end
    matrix
  end

  def colour(row, column, color, matrix)
    matrix[column - 1][row - 1] = color
    matrix
  end

  def vertical_draw(row, from_column, to_column, colour, matrix)
    (from_column - 1..to_column - 1).each do |col|
      matrix[col][row - 1] = colour
    end
    matrix
  end

  def horizontal_draw(from_row, to_row, column, colour, matrix)
    (from_row - 1..to_row - 1).each do |row|
      matrix[column - 1][row] = colour
    end
    matrix
  end

  def show_matrix(matrix)
    matrix.each do |table|
      puts table.join
    end
  end

  def check_first_line(line)
    if line.match(/^I\s\d+\s\d+$/)
      true
    else
      false
    end
  end
end
