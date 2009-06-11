ary = []

open('data.txt') {|file| file.each {|line| ary << line.to_i }}

def bubble_sort(ary)
  for i in 0...ary.size-1
    for j in 0...ary.size-1-i
      ary[j+1], ary[j] = ary[j], ary[j+1] if ary[j] > ary[j+1]
    end
  end
  ary
end

bubble_sort(ary).each {|elt| puts elt }
