class ListsController < ApplicationController
  before_filter :require_user

  # GET /lists
  # GET /lists.xml
  def index
    # @lists = List.all

    # respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @lists }
    # end
    flash[:notice] = "You should be logged in as 'Admin' to see this page."
    redirect_to new_list_url
  end

  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="lists.xls"'
    headers['Cache-Control'] = ''
    @lists =  List.find(:all, :conditions => {:status => 'Approved'})
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
    @list   = List.new(params[:list]) || List.new
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

  def check_url
    url = params[:list_url]
    list = nil
    format = nil

    if !url.match(/(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix).nil?
      format = "OK"
      list = List.find_by_url(url)
    end

    if format.nil?
      render :js => "$('ok').style.display = 'none'; $('error').style.display = 'none'; $('format').style.display = 'block'"
    else
      if list.nil?
        render :js => "$('error').style.display = 'none'; $('format').style.display = 'none', $('ok').style.display = 'block'"
      else
        render :js => "$('ok').style.display = 'none'; $('format').style.display = 'none', $('error').style.display = 'block'"
      end
    end
  end

  def approve
    @list = List.find(params[:id])

    if @list.update_attribute('status', 'Approved')
      flash[:notice] = 'List approved!'
      redirect_to admin_lists_url
    else
      flash[:notice] = 'Unable to approve list this time!'
      redirect_to admin_lists_url
    end
  end

  def reject
    @list = List.find(params[:id])

    if @list.update_attribute('status', 'Rejected')
      flash[:notice] = 'List rejected!'
      redirect_to admin_lists_url
    else
      flash[:notice] = 'Unable to reject list this time!'
      redirect_to admin_lists_url
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
        if s1id > 1
          if params['1subcats2']
            s2id = params['1subcats2'][:id].to_i
            if s2id > 1
              if params['1subcats3']
                s3id = params['1subcats3'][:id].to_i
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
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
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
        if s1id > 1
          if params['2subcats2']
            s2id = params['2subcats2'][:id].to_i
            if s2id > 1
              if params['2subcats3']
                s3id = params['2subcats3'][:id].to_i
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
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
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
        if s1id > 1
          if params['3subcats2']
            s2id = params['3subcats2'][:id].to_i
            if s2id > 1
              if params['3subcats3']
                s3id = params['3subcats3'][:id].to_i
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
              category = Category.find(s1id)
              @categories << category
            end
          else
            category = Category.find(s1id)
            @categories << category
          end
        else
          category = Category.find(params['3categories'][:id])
          @categories << category
        end
      end
    else
      puts "3 Categories is blank!"
    end

    @list.categories << @categories
    @list.user = current_user

    respond_to do |format|
      if @list.save
        flash[:notice] = 'List was successfully created.'
        format.html { redirect_to(new_list_url) }
        format.xml  { render :xml => @list, :status => :created, :location => @list }
      else
        msg = '<div id="errorExplanation" class="errorExplanation">'
        msg += "<h2>#{@list.errors.size} errors prohibited this list from being saved</h2>"
        msg += '<p>There were problems with the following fields:</p>'
        msg += '<ul>'
        @list.errors.full_messages.each do |m|
          msg += '<li>' + m + '</li>'
        end
        msg += '</ul></div>'
        flash[:notice] = msg
        format.html { redirect_to new_list_url }
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

