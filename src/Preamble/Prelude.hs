{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

-- | Local Prelude.
--
module Preamble.Prelude
  ( module Exports
  , maybe'
  , maybe_
  , eitherThrowIO
  , maybeThrowIO
  , boolThrowIO
  , textFromString
  , (-/-)
  , (-.-)
  , (-:-)
  ) where

import BasicPrelude as Exports
import Control.Lens as Exports hiding (uncons, (.=), (<.>))
import Data.Text

-- | maybe with hanging function.
--
maybe' :: Maybe a -> b -> (a -> b) -> b
maybe' m b a = maybe b a m

-- | Maybe that returns () if Nothing
--
maybe_ :: Monad m => Maybe a -> (a -> m ()) -> m ()
maybe_ = flip $ maybe $ return ()

-- | Throw userError on either error.
--
eitherThrowIO :: MonadIO m => Either String a -> m a
eitherThrowIO = either (liftIO . throwIO . userError) return

-- | Throw userError on maybe nothing.
--
maybeThrowIO :: MonadIO m => String -> Maybe a -> m a
maybeThrowIO s = maybe (liftIO $ throwIO $ userError s) return

-- | Throw userError on false.
--
boolThrowIO :: MonadIO m => String -> Bool -> m ()
boolThrowIO = flip unless . liftIO . throwIO . userError

-- | Reverse of textToString
--
textFromString :: String -> Text
textFromString = pack

-- | </> for IsString.
--
(-/-) :: (IsString s, Monoid s) => s -> s -> s
(-/-) = (<>) . (<> "/")

-- | <.> for IsString.
--
(-.-) :: (IsString s, Monoid s) => s -> s -> s
(-.-) = (<>) . (<> ".")

-- | <:> for IsString.
--
(-:-) :: (IsString s, Monoid s) => s -> s -> s
(-:-) = (<>) . (<> ":")
