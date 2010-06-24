class ListsController < ApplicationController
  before_filter :require_user

  # GET /lists
  # GET /lists.xml
  def index
    @lists = List.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lists }
    end
  end

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="lists.xls"'
    headers['Cache-Control'] = ''
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.xml
  def show
    @list = List.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.xml
  def new
    @list   = List.new
    3.times { @list.categories.build }

    @categories = []
    root = Category.root
    @categories << root
    root.siblings.each do |s|
      @categories << s
    end
    @categories

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
    (3 - @list.categories.size).times { @list.categories.build }
  end

  # POST /lists
  # POST /lists.xml
  def create
    @list = List.new(params[:list])
    @categories = Array.new

    if !params['1categories'][:id].blank?
      if params['1subcats1']
        s1id = params['1subcats1'][:id].to_i
        puts "Cat 1 Sub 1 :" + s1id.to_s
        if s1id > 1
          if params['1subcats2']
            s2id = params['1subcats2'][:id].to_i
            puts "Cat 1 Sub 2 :" + s2id.to_s
            if s2id > 1
              if params['1subcats3']
                s3id = params['1subcats3'][:id].to_i
                puts "Cat 1 Sub 3 :" + s3id.to_s
                if s3id > 1
                  category = Category.find(s3id)
                  @categories << category
                else
                  category = Category.find(s2id)
                  @categories << category
                end
              else
                category = Category.find(s2id)
                @categories << category
              end
            else
              puts "Finding sub category 1"
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
          puts "Couldn't find subcategories so finding category 1"
          category = Category.find(params['1categories'][:id])
          @categories << category
        end
      end
    else
      puts "1 Categories is blank!"
    end

    if !params['2categories'][:id].blank?
      if params['2subcats1']
        s1id = params['2subcats1'][:id].to_i
        puts "Cat 2 Sub 1 :" + s1id.to_s
        if s1id > 1
          if params['2subcats2']
            s2id = params['2subcats2'][:id].to_i
            puts "Cat 2 Sub 2 :" + s2id.to_s
            if s2id > 1
              if params['2subcats3']
                s3id = params['2subcats3'][:id].to_i
                puts "Cat 2 Sub 3 :" + s3id.to_s
                if s3id > 1
                  category = Category.find(s3id)
                  @categories << category
                else
                  category = Category.find(s2id)
                  @categories << category
                end
              else
                category = Category.find(s2id)
                @categories << category
              end
            else
              puts 'finding subcategories 2'
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
          puts "Couldn't find subcategories so finding category 2"
          category = Category.find(params['2categories'][:id])
          @categories << category
        end
      end
    else
      puts "2 Categories is blank!"
    end

    if !params['3categories'][:id].blank?
      if params['3subcats1']
        s1id = params['3subcats1'][:id].to_i
        puts "Cat 3 Sub 1 :" + s1id.to_s
        if s1id > 1
          if params['3subcats2']
            s2id = params['3subcats2'][:id].to_i
            puts "Cat 3 Sub 2 :" + s2id.to_s
            if s2id > 1
              if params['3subcats3']
                s3id = params['3subcats3'][:id].to_i
                puts "Cat 3 Sub 3 :" + s3id.to_s
                if s3id > 1
                  category = Category.find(s3id)
                  @categories << category
                else
                  category = Category.find(s2id)
                  @categories << category
                end
              else
                category = Category.find(s2id)
                @categories << category
              end
            else
              puts 'finding subcategories 3'
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
          puts "Couldn't find subcategories so finding category 3"
          category = Category.find(params['3categories'][:id])
          @categories << category
        end
      end
    else
      puts "3 Categories is blank!"
    end

    puts "No. of categories selected: " + @categories.size.to_s
    @list.categories << @categories

    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.html { redirect_to(@list) }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.xml
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        flash[:notice] = 'List was successfully updated.'
        format.html { redirect_to(@list) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @list.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.xml
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to(lists_url) }
      format.xml  { head :ok }
    end
  end
end

