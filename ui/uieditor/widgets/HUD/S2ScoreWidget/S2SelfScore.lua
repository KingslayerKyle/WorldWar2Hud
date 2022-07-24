CoD.S2SelfScore = InheritFrom( LUI.UIElement )
CoD.S2SelfScore.new = function ( menu, controller )
	local self = LUI.UIElement.new()

	if PreLoadFunc then
		PreLoadFunc( self, controller )
	end

	self:setUseStencil( false )
	self:setClass( CoD.S2SelfScore )
	self.id = "S2SelfScore"
	self.soundSet = "default"
	self:setLeftRight( true, false, 0, 1280 )
	self:setTopBottom( true, false, 0, 720 )
	self.anyChildUsesUpdateState = true

	self.PortraitImage = LUI.UIImage.new()
	self.PortraitImage:setLeftRight( true, false, 26.5, 104 )
	self.PortraitImage:setTopBottom( false, true, -132, -54.5 )
	self.PortraitImage:setImage( RegisterImage( "blacktransparent" ) )
	self.PortraitImage:linkToElementModel( self, "zombiePlayerIcon", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char1" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_nikolai_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char1_old" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_nikolai_old_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char2" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_takeo_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char2_old" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_takeo_old_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char3" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_dempsey_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char3_old" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_dempsey_old_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char4" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_richtofen_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char4_old" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_richtofen_old_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char5" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_jessica_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char6" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_jack_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char7" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_nero_circle" ) )

			elseif Engine.GetModelValue( modelRef ) == "uie_t7_zm_hud_score_char8" then
				self.PortraitImage:setImage( RegisterImage( "hud_player_floyd_circle" ) )
			end
		end
	end )
	self:addElement( self.PortraitImage )

	self.ScoreTextShadow = LUI.UIText.new()
	self.ScoreTextShadow:setLeftRight( true, true, 109.5, 0 )
	self.ScoreTextShadow:setTopBottom( false, true, -116, -78.5 )
	self.ScoreTextShadow:setTTF( "fonts/dinnextslabpro-regular.ttf" )
	self.ScoreTextShadow:setRGB( 0.11, 0.11, 0.11 )
	self.ScoreTextShadow:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.ScoreTextShadow:linkToElementModel( self, "playerScore", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreTextShadow:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.ScoreTextShadow )

	self.ScoreText = LUI.UIText.new()
	self.ScoreText:setLeftRight( true, true, 111, 0 )
	self.ScoreText:setTopBottom( false, true, -117.5, -80 )
	self.ScoreText:setTTF( "fonts/dinnextslabpro-regular.ttf" )
	self.ScoreText:setRGB( 0.65, 0.63, 0.57 )
	self.ScoreText:setAlignment( Enum.LUIAlignment.LUI_ALIGNMENT_LEFT )
	self.ScoreText:linkToElementModel( self, "playerScore", true, function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ScoreText:setText( Engine.Localize( Engine.GetModelValue( modelRef ) ) )
		end
	end )
	self:addElement( self.ScoreText )

	self.HealthBar = LUI.UIImage.new()
	self.HealthBar:setLeftRight( true, false, 16.5, 114 )
	self.HealthBar:setTopBottom( false, true, -142, -44.5 )
	self.HealthBar:setImage( RegisterImage( "uie_t7_zm_hud_revive_ringtop" ) )
	self.HealthBar:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_clock_normal" ) )
	self.HealthBar:setRGB( 0.88, 0.77, 0.49 )
	self.HealthBar:setShaderVector( 0, 1, 0, 0, 0 )
	self.HealthBar:setShaderVector( 1, 0.5, 0, 0, 0 )
	self.HealthBar:setShaderVector( 2, 0.5, 0, 0, 0 )
	self.HealthBar:setShaderVector( 3, 0, 0, 0, 0 )
	self.HealthBar:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "S2.Health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) ~= nil then
				if Engine.GetModelValue( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.perks.juggernaut" ) ) > 0 then
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )

					if Engine.GetModelValue( modelRef ) <= 200 / 3 then
						self.HealthBar:setRGB( 1, 0.22, 0.22 )
					else
						self.HealthBar:setRGB( 0.88, 0.77, 0.49 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 200, 4 ) )
					)
				else
					self.HealthBar:beginAnimation( "keyframe", 400, false, false, CoD.TweenType.Linear )
					
					if Engine.GetModelValue( modelRef ) <= 100 / 3 then
						self.HealthBar:setRGB( 1, 0.22, 0.22 )
					else
						self.HealthBar:setRGB( 0.88, 0.77, 0.49 )
					end

					self.HealthBar:setShaderVector( 0, AdjustStartEnd( 0, 1,
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 1 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 2 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 3 ),
						CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ) / 100, 4 ) )
					)
				end
			end
		end
	end )
	self:addElement( self.HealthBar )

	self.ShieldHealth = LUI.UIImage.new()
	self.ShieldHealth:setLeftRight( true, false, 59, 71 )
	self.ShieldHealth:setTopBottom( false, true, -76, -64 )
	self.ShieldHealth:setImage( RegisterImage( "blacktransparent" ) )
	self.ShieldHealth:setRGB( 0.88, 0.77, 0.49 )
	self.ShieldHealth:setMaterial( LUI.UIImage.GetCachedMaterial( "uie_wipe_delta_normal" ) )
	self.ShieldHealth:setShaderVector( 0, 0, 1, 0, 0 )
	self.ShieldHealth:setShaderVector( 1, 0, 0, 0, 0 )
	self.ShieldHealth:setShaderVector( 3, 0, 0, 0, 0 )
	self.ShieldHealth:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == 1 then
				self.ShieldHealth:setImage( RegisterImage( "hud_shield_fill" ) )
			else
				self.ShieldHealth:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self.ShieldHealth:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "ZMInventory.shield_health" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			self.ShieldHealth:setShaderVector( 2, SetVectorComponent( 2, 1, SubtractVectorComponentFrom( 1, 0.6, ScaleVector( 0.5,
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 1 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 2 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 3 ),
				CoD.GetVectorComponentFromString( Engine.GetModelValue( modelRef ), 4 ) ) ) )
			)
		end
	end )
	self:addElement( self.ShieldHealth )

	self.ShieldOutline = LUI.UIImage.new()
	self.ShieldOutline:setLeftRight( true, false, 59, 71 )
	self.ShieldOutline:setTopBottom( false, true, -76, -64 )
	self.ShieldOutline:setImage( RegisterImage( "blacktransparent" ) )
	self.ShieldOutline:setRGB( 0.88, 0.77, 0.49 )
	self.ShieldOutline:subscribeToModel( Engine.GetModel( Engine.GetModelForController( controller ), "hudItems.showDpadDown" ), function ( modelRef )
		if Engine.GetModelValue( modelRef ) then
			if Engine.GetModelValue( modelRef ) == 1 then
				self.ShieldOutline:setImage( RegisterImage( "hud_shield_empty" ) )
			else
				self.ShieldOutline:setImage( RegisterImage( "blacktransparent" ) )
			end
		end
	end )
	self:addElement( self.ShieldOutline )

	LUI.OverrideFunction_CallOriginalSecond( self, "close", function ( element )
		element.PortraitImage:close()
		element.ScoreTextShadow:close()
		element.ScoreText:close()
		element.HealthBar:close()
		element.ShieldHealth:close()
		element.ShieldOutline:close()
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, controller, menu )
	end
	
	return self
end
