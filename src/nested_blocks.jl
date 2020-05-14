# Examples
"""

R=2
C=3

println("2D pseudo-index fill ...")
A=init_nested_blocks(R,C)
for c=1:C,r=1:R
    put_nested_block!(randn(1,1),A,r,c)
    # or just A[r][c]=r*c
end
display(A);println()
display(A[1]);println()
display(A[1][1]);println()

println("linear fill column-wise ...")
A=init_nested_blocks(R,C)
for i=1:R*C put_nested_block!(string(i),A,i) end
display(A);println()
display(A[1]);println()
display(A[1][1]);println()

println("linear fill row-wise")
A=init_nested_blocks(R,C)
for i=1:R*C put_nested_block!(string(i),A,i,colwise=false) end
display(A);println()
display(A[1]);println()
display(A[1][1]);println()

"""

export init_nested_blocks
"""
    julia> A = init_nested_blocks(R,C)

Initialize empty Vector{Vector} - pseudo-2D nested block array with

- R number of rows
- C number of columns

Row blocks can be accessed using A[r]

Single blocks can be accessed with A[r][c]

"""
function init_nested_blocks(R::Integer,C::Integer)
    A=Vector{Vector}(undef,R)
    for r=1:R
        A[r]=Vector{Any}(undef,C)
    end
    return A
end

export put_nested_block!
"""
    julia> put_nested_block!(O,A,r,c)

Assign any object to element of Vector{Vector} created with `init_nested_blocks`, where

- O is any object
- A is Vector{Vector} from `init_nested_blocks`
- r is row index
- c is column index

This is equivalent to A[r][c]=O

"""
function put_nested_block!(O,A::Vector{Vector},r::Integer,c::Integer)
    A[r][c]=O
    return nothing
end

export put_nested_block_row_wise!
"""
    julia> put_nested_block_row_wise!(O,A,l)

Assign any object to element of Vector{Vector} created with `init_nested_blocks`, uing linear index in row-wise convention, where

- O is any object
- A is Vector{Vector} from `init_nested_blocks`
- l is linear index in row-wise convention

"""
function put_nested_block_row_wise!(O,A,l::Integer)
    R=size(A,1)
    C=size(A[1],1)
    @assert l > 0
    @assert l <= R*C
    r=ceil(Int,l/C)
    c=(l-1)%C+1
    A[r][c]=O
    return nothing
end

export put_nested_block_col_wise!
"""
    julia> put_nested_block_col_wise!(O,A,l)

Assign any object to element of Vector{Vector} created with `init_nested_blocks`, uing linear index in column-wise convention, where

- O is any object
- A is Vector{Vector} from `init_nested_blocks`
- l is linear index in column-wise convention

"""
function put_nested_block_col_wise!(O,A::Vector{Vector},l::Integer)
    R=size(A,1)
    C=size(A[1],1)
    @assert l > 0
    @assert l <= R*C
    c=ceil(Int,l/R)
    r=(l-1)%R+1
    A[r][c]=O
    return nothing
end

export put_nested_block!
"""
    julia> put_nested_block!(O,A,l;colwise=true)

Assign any object to element of Vector{Vector} created with `init_nested_blocks`, uing linear index in selected convention, where

- O is any object
- A is Vector{Vector} from `init_nested_blocks`
- l is linear index in selected convention
- colwise keyword
    - true uses column-wise convention (default)
    - false uses row-wise convention

"""
function put_nested_block!(O,A::Vector{Vector},l::Integer;colwise::Bool=true)
    if colwise
        put_nested_block_col_wise!(O,A,l)
    else
        put_nested_block_row_wise!(O,A,l)
    end
end

