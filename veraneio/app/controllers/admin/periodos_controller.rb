class Admin::PeriodosController < ApplicationController
  layout 'admin'
  before_action :set_admin_periodo, only: [:show, :edit, :update, :destroy]

  # GET /admin/periodos
  # GET /admin/periodos.json
  def index
    @admin_periodos = Periodo.order('termino DESC').all
    @admin_periodo = Periodo.new
    @periodo_atual = Periodo.where(termino: Periodo.maximum('termino')).first
    @termino = DateTime.new
    @inicio = DateTime.new
  end

  # GET /admin/periodos/1
  # GET /admin/periodos/1.json
  def show
  end

  # GET /admin/periodos/1/edit
  def edit
  end

  # POST /admin/periodos
  # POST /admin/periodos.json
  def create
#    @admin_periodo = Periodo.new admin_periodo_params


    @periodo_trabalho = PeriodoTrabalho.new inicio: params[:trabalho_inicio], termino: params[:trabalho_termino]
    @periodo_avaliacao = PeriodoAvaliacao.new inicio: params[:avaliacao_inicio], termino: params[:avaliacao_termino]

	puts "debug #{@periodo_trabalho}" 
	puts "debug #{params[:trabalho_inicio]}" 
    @periodo_atual = PeriodoAvaliacao.where(termino: PeriodoAvaliacao.maximum('termino')).first

    respond_to do |format|
      if !@periodo_atual.nil? and @periodo_trabalho.inicio < @periodo_atual.termino
        format.html { redirect_to admin_periodos_path, alert: 'Nao e possivel criar um novo Periodo. Data inicial e menor que a data final do ultimo periodo valido.' }
	      elsif !@periodo_atual.nil? and @periodo_avaliacao.termino < @periodo_avaliacao.inicio or @periodo_trabalho.termino > @periodo_trabalho.inicio
        format.html { redirect_to admin_periodos_path, alert: 'Periodo invalido. Data final e menor que data inicial.' }        
      elsif @periodo_trabalho.save and @periodo_avaliacao.save
        format.html { redirect_to admin_periodos_path, notice: 'Períodos criados com sucesso.' }
        format.json { render :show, status: :created, location: @admin_periodo }
      else
        format.html { render :new }
        format.json { render json: @admin_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/periodos/1
  # PATCH/PUT /admin/periodos/1.json
  def update
    respond_to do |format|
      if @admin_periodo.update admin_periodo_params 
        format.html { redirect_to admin_periodo_path(@admin_periodo), notice: 'Período atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @admin_periodo }
      else
        format.html { render :edit }
        format.json { render json: @admin_periodo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/periodos/1
  # DELETE /admin/periodos/1.json
  def destroy
    @admin_periodo.destroy
    respond_to do |format|
      format.html { redirect_to admin_periodos_url, notice: 'Período foi apagado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_periodo
      @admin_periodo = Periodo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_periodo_params
      params.require(:periodo).permit(:inicio, :termino)
    end


end
