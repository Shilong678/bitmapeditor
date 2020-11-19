# frozen_string_literal: true

module BitmapError

   
  def row_error?(row, matrix_row, command)
    if row > matrix_row
      raise "Your command row: #{command} is greater than matrix table"
    end
  end

  def column_error?(column, matrix_column, command)
    if column > matrix_column
      raise "Your command column: #{command} is greater than matrix table"
    end
  end
end
