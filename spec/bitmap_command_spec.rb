# frozen_string_literal: true

require File.expand_path 'spec_helper.rb', __dir__
require File.expand_path '../lib/bitmap_command.rb', __dir__

describe 'Bitmap Command' do
  let(:dummy_class) { Class.new { extend BitmapCommand } }

  let(:matrix) do
    [%w[O O O O O], %w[O O O O O], %w[O O O O O], %w[O O O O O], %w[O O O O O], %w[O O O O O]]
  end
  it 'creates a matrix' do
    expect(dummy_class.create(5, 6)).to eq(matrix)
  end

  it 'clears the matrix table' do
    neo = [%w[O B A O O], %w[C O O D E], %w[O O F G O], %w[O O O O O], %w[H H H H H], %w[I O J O M]]
    expect(dummy_class.clear(neo)).to eq(matrix)
  end

  it 'colours the pixel ' do
    trinity = [%w[O O O O O], %w[O O O O O], %w[O O O W O], %w[O O O O O], %w[O O O O O], %w[O O O O O]]
    expect(dummy_class.colour(4, 3, 'W', matrix)).to eq(trinity)
  end

  it 'draw a vertical segment' do
    morpheus = [%w[O O O O O], %w[O O O O O], %w[O D O O O], %w[O D O O O], %w[O D O O O], %w[O O O O O]]
    expect(dummy_class.vertical_draw(2, 3, 5, 'D', matrix)).to eq(morpheus)
  end

  it 'draw a horizontal segment' do
    smith = [%w[O O O O O], %w[O O Z Z Z], %w[O O O O O], %w[O O O O O], %w[O O O O O], %w[O O O O O]]
    expect(dummy_class.horizontal_draw(3, 5, 2, 'Z', matrix)).to eq(smith)
  end

  it 'shows the contents' do
    the_oracle = [%w[O A O O O], %w[O O Z Z Z], %w[O O D O O], %w[O O D O O]]
    z = /OAOOO/
    i = /OOZZZ/
    o = /OODOO/
    n = /OODOO/
    expect { dummy_class.show_matrix(the_oracle) }.to output(z).to_stdout
    expect { dummy_class.show_matrix(the_oracle) }.to output(i).to_stdout
    expect { dummy_class.show_matrix(the_oracle) }.to output(o).to_stdout
    expect { dummy_class.show_matrix(the_oracle) }.to output(n).to_stdout
  end

  it 'checks first line start with I command' do
    good_line = 'I 6 7'
    bad_line = 'F 3 5'
    expect(dummy_class.check_first_line(bad_line)).to be false
    expect(dummy_class.check_first_line(good_line)).to be true
  end
end
